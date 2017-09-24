class CheckoutController < ApplicationController
  before_action :authenticate_user!, except: [:start]
  before_action :init_vars


  def start
    save_cart_if_no_auth
    redirect_to :checkout
  end

  def index
    #we start checkout or select necessary stage
    save_cart if cookies[:save_cart]
    check_order

    flash[:return_to_comfirm] = true unless params[:edit].blank?

    case @state_layout
    when 'address'
      @billing_address = @user.billing_address || @user.build_billing_address
      @shipping_address = @user.shipping_address || @user.build_shipping_address
    when 'delivery'
      @delivery_methods = DeliveryMethod.all
    when 'payment'
      @credit_card = @order.credit_card || @order.build_credit_card
    when 'confirm'
      @address = @order.order_address
      @card_number = "** ** ** #{@order.credit_card.number.last(4)}"
      @items = @order.order_items
    when 'complete'
      @address = @order.order_address
      @items = @order.order_items
    else
    end
  end

  def check_order
    if @order.order_items.blank?
      if @order.checkout_state != 'address'
        @order.checkout_state = "address"
        @order.save
      end
      flash[:alert] = "You cart is empty"
      redirect_to cart_page_url
    end
  end

  def next_stage
    status = :ok

    case @state_layout
    when 'address'
      status = processing_address
    when 'delivery'
      status = processing_delivery
    when 'payment'
      status = processing_payment
    when 'confirm'
      status = processing_confirm
    #when 'complete'
    #  status = processing_complete
    else
      status = :error
    end

    unless flash[:return_to_comfirm].nil?
      if status == :error
        flash.keep
      else
        @order.checkout_state = :confirm
        @order.save
      end
    end

    render "index" and return if status == :error

    redirect_to :checkout
  end

  def edit_data
    #pry
    @order.checkout_state = state_params[:type]
    @order.save!
    redirect_to checkout_url(edit: :edit)
  end

  def processing_address
    params[:user].delete(:shipping_address_attributes) if(params[:use_billing] == "on")

    if @user.update(user_params)
      save_addresses_to_order(params[:use_billing])
      last_order.next_state! and return :success
    end

    return :error
  end

  def processing_delivery
    last_order.next_state! and return :success if @order.update(delivery_params)
    return :error
  end

  def processing_payment
    last_order.next_state! and return :success if @order.update(payment_params)
    return :error
  end

  def processing_confirm
    @order.completed_at = DateTime.now
    @order.total_price = @order.pre_total_price
    @order.status = 1
    #pry

    if @order.save
      @order.next_state!
      flash[:last_completed_order_id] = @order.id

      #pry
      return :success
    end

    return :error
  end

  def processing_complete
  end


  def save_addresses_to_order(use_billing = nil)
    keys = ['first_name', 'last_name', 'address', 'city', 'zip', 'country', 'phone']
    data = {}
    bl_address_data = @user.billing_address

    keys.each do |item|
      data["billing_#{item}".to_sym] = bl_address_data[item]
    end

    if use_billing == "on"
      keys.each do |item|
        data["shipping_#{item}".to_sym] = bl_address_data[item]
      end
    else
      sh_address_data = @user.shipping_address
      keys.each do |item|
        data["shipping_#{item}".to_sym] = sh_address_data[item]
      end
    end

    last_order.build_order_address(data).save
  end

  def init_vars
    #pry
    if flash[:last_completed_order_id].nil?
      @order = last_order
      #flash.keep
    else
      @order = Order.find(flash[:last_completed_order_id])
    end

    @state_layout = @order.checkout_state
    @user = current_user
    #pry
    #@subtotal = @order.subtotal
  end

  private


    def save_cart_if_no_auth
      #pry
      unless user_signed_in?
        unless last_order.order_items.blank?
          cookies[:save_cart] = true
        end
      end
    end

    def save_cart
      #cookies.signed[:order_id] = order.id
      order = Order.find_by(id: cookies.signed[:order_id], status: :in_progress)
      if order
        @order.delete
        order.user = current_user
        order.save
        init_vars
        #@order.save
        cookies.delete(:save_cart)
        cookies.delete(:order_id)
      end
    end

    def user_params
      params.require(:user).permit(
        billing_address_attributes: [:first_name, :last_name, :address, :city, :zip, :country, :phone, :id],
        shipping_address_attributes: [:first_name, :last_name, :address, :city, :zip, :country, :phone, :id])
    end

    def delivery_params
      params.require(:order).permit( :delivery_method_id )
    end

    def payment_params
      params.require(:order).permit( credit_card_attributes: [:number, :name, :cvv, :expires] )
    end

    def state_params
      params.permit(:type)
    end
end

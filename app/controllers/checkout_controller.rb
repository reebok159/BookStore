class CheckoutController < ApplicationController
  before_action :authenticate_user!, :init_vars

  def index
    #we start checkout or select necessary stage

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
      #status = processing_confirm
    when 'complete'
      #status = processing_complete
    else

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
    when 'complete'
      status = processing_complete
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
    pry
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
    @order = last_order
    @state_layout = @order.checkout_state
    @user = current_user

  end

  private

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

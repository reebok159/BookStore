class CheckoutController < ApplicationController
  before_action :authenticate_user!, except: [:start]
  before_action :init_vars

  include CheckoutHelper

  def index
    save_cart_after_login if cookies[:save_cart]
    check_order
    cookies[:return_to_confirm] = true unless params[:edit].blank?

    show_current_step(@state_layout)
  end

  def start
    start_save_cart_if_no_auth
    redirect_to :checkout
  end

  def check_order
    return unless @order.order_items.blank?
    @order.reset_state! unless @order.address?
    flash[:alert] = t('checkout.emptycart')
    redirect_to cart_page_url
  end

  def show_current_step(state_layout)
    eval("#{state_layout}_page")
  rescue
    address_page
  end

  def next_stage
    service = CheckoutService.new(params, cookies, @user, @order)
    status = service.next_stage(@state_layout)
    service.return_to_confirm?(status)
    complete_order if status == :success && @state_layout == 'confirm'

    render "index" and return if status == :error
    redirect_to :checkout
  end

  def address_page
    @billing_address = @user.billing_address || @user.build_billing_address
    @shipping_address = @user.shipping_address || @user.build_shipping_address
  end

  def delivery_page
    @delivery_methods = DeliveryMethod.all
  end

  def payment_page
    @credit_card = @order.credit_card || @order.build_credit_card
  end

  def confirm_page
    @address = @order.order_address
    @items = @order.order_items.decorate
  end

  def complete_page
    @address = @order.order_address
    @items = @order.order_items.decorate
  end

  def complete_order
    flash[:last_completed_order_id] = @order.id
  end

  def edit_data
    @order.checkout_state = state_params[:type]
    @order.save!
    redirect_to checkout_url(edit: :edit)
  end

  def init_vars
    @user = current_user
    last_completed_order_id = flash[:last_completed_order_id]
    @order = if last_completed_order_id.nil?
               last_order
             else
               @user.orders.find(last_completed_order_id)
             end
    @order = @order.decorate
    @state_layout = @order.checkout_state
  end

  private

  def start_save_cart_if_no_auth
    return if user_signed_in?
    cookies[:save_cart] = true unless last_order.order_items.blank?
  end

  def save_cart_after_login
    order = Order.find_by(id: cookies.signed[:order_id], status: :in_progress)
    return unless order

    @order.delete
    order.user = current_user
    order.save
    init_vars
    cookies.delete(:save_cart)
    cookies.delete(:order_id)
  end

  def state_params
    params.permit(:type)
  end
end

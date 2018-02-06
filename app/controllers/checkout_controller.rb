class CheckoutController < ApplicationController
  before_action :authenticate_user!, except: [:start]
  before_action :save_cart_after_login
  before_action :init
  before_action :check_order_not_empty

  def start
    start_save_cart_if_no_auth
    cookies.delete(:return_to_confirm)
    redirect_to :checkout
  end

  def index
    @form = CheckoutForm.new(@order)
  end

  def edit_data
    @order.checkout_state = state_params[:type]
    return unless @order.save
    cookies[:return_to_confirm] = true
    redirect_to :checkout
  end

  def next_stage
    status = @service.next_stage(@state_layout)
    @service.return_to_confirm?(status)
    if status == :success
      save_order_for_last_step if @state_layout == 'confirm'
      return redirect_to :checkout
    end
    @form = CheckoutForm.new(@order)
    render 'index'
  end

  private

  def init
    @user = current_user
    @order = select_order.decorate
    @state_layout = @order.checkout_state
    @service = CheckoutService.new(params, cookies, @user, @order)
  end

  def check_order_not_empty
    return unless @order.order_items.blank?
    @order.reset_state! unless @order.address?
    flash[:alert] = t('checkout.emptycart')
    redirect_to cart_page_url
  end

  def select_order
    last_completed_order_id = flash[:last_completed_order_id]
    return last_order if last_completed_order_id.nil?
    @user.orders.find_by(id: last_completed_order_id)
  end

  def save_order_for_last_step
    flash[:last_completed_order_id] = @order.id
  end

  def start_save_cart_if_no_auth
    return if user_signed_in?
    cookies[:save_cart] = true unless last_order.order_items.blank?
  end

  def save_cart_after_login
    return unless cookies[:save_cart]
    order = guest_order
    return unless order
    last_order.destroy
    order.update_attributes(user: current_user)
    clear_guest_cookies
  end

  def state_params
    params.permit(:type)
  end
end

# frozen_string_literal: true

class CheckoutController < ApplicationController
  include Wicked::Wizard
  before_action :authenticate_user!, only: %i[show update]
  before_action :redirect_if_empty, :init

  steps :address, :delivery, :payment, :confirm, :complete

  def show
    goto_active_step
    cookies.delete(:last_completed_order_id) if step == :complete
    render_wizard
  end

  def update
    change_state if @form.update(order_params, step)
    render_wizard @form.order
  end

  private

  def init
    @form = CheckoutForm.new(active_order.decorate)
  end

  def change_state
    @form.order.update(checkout_state: :confirm) && return if return_to_confirm?
    @form.order.next_state!
    save_order_for_last_step if step == :confirm
  end

  def return_to_confirm?
    return true if params.key?(:edit) && @form.filled?
  end

  def redirect_if_empty
    redirect_to cart_page_path, flash: { alert: t('checkout.emptycart') } unless active_order.order_items.present?
  end

  def goto_active_step
    @form.order.update(checkout_state: step) if params.key?(:edit)
    jump_to(@form.order.checkout_state) unless step.to_s == @form.order.checkout_state
  end

  def active_order
    last_completed_order_id = cookies.signed[:last_completed_order_id]
    return last_order unless last_completed_order_id
    current_user.orders.find_by(id: last_completed_order_id)
  end

  def save_order_for_last_step
    cookies.signed[:last_completed_order_id] = @form.order.id
  end

  def order_params
    params.fetch(:order, {}).permit(
      :use_billing,
      :delivery_method,
      credit_card: %i[number name cvv expires],
      billing_address: %i[first_name last_name address city zip country phone],
      shipping_address: %i[first_name last_name address city zip country phone]
    )
  end
end

# frozen_string_literal: true

class CheckoutForm
  include ActiveModel::Model

  attr_accessor :order

  def initialize(order)
    @order = order
  end

  def update(params, step)
    @params = params
    case step
    when :address then processing_address
    when :delivery then
      @order.delivery_method = DeliveryMethod.find_by(id: @params[:delivery_method])
    when :payment then @order.build_credit_card(@params[:credit_card])
    when :confirm then processing_confirm
    end
    @order.save
  end

  def billing_address_form
    @order.billing_address || @order.user.billing_address || @order.build_billing_address
  end

  def shipping_address_form
    @order.shipping_address || @order.user.shipping_address || @order.build_shipping_address
  end

  def delivery_methods
    DeliveryMethod.all
  end

  def credit_cart_form
    @order.credit_card || @order.build_credit_card
  end

  def filled?
    return false unless @order.credit_card&.valid? && @order.delivery_method&.valid? &&
                        @order.billing_address&.valid? && @order.shipping_address&.valid?
    true
  end

  private

  def processing_address
    @order.build_billing_address(@params[:billing_address])
    if @params.key? :use_billing
      @order.build_shipping_address(@params[:billing_address])
      @order.use_billing = true
      return
    end
    @order.build_shipping_address(@params[:shipping_address])
    @order.use_billing = nil
  end

  def processing_confirm
    @order.completed_at = Time.current
    @order.total_price = @order.pre_total_price
    @order.status = :in_queue
    @order.save
  end
end

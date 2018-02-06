class CheckoutForm
  include ActiveModel::Model

  attr_accessor :billing_address, :shipping_address, :credit_card

  def initialize(order)
    @order = order
    @credit_card = credit_cart_form
    @billing_address = billing_address_form
    @shipping_address = shipping_address_form
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
end

class OrderService
  attr_reader :params, :user, :order

  def initialize(order)
    @order = order
  end

  def activate_coupon(coupon_code)
    coupon = Coupon.find_by(code: coupon_code)
    response = can_activate_coupon?(coupon)
    return response if response != :ok
    @order.coupon = coupon
    @order.save
    :success
  end

  def can_activate_coupon?(coupon)
    return I18n.t('coupon.noexist') if coupon.nil?
    return I18n.t('coupon.cantactivate') if @order.order_items.blank?
    return I18n.t('coupon.sumerror') if @order.subtotal < coupon.min_sum_to_activate
    return I18n.t('coupon.termerror') if DateTime.now > coupon.expires
    :ok
  end
end

class OrderService
  attr_reader :params, :user, :order

  def initialize(order)
    @order = order
  end

  def save_coupon_with_message(coupon_code)
    coupon = Coupon.find_by(code: coupon_code)
    response = check_coupon(coupon)
    return response if response != true
    @order.coupon = coupon
    @order.save and return I18n.t('coupon.activatesuccess')
  end

  def check_coupon(coupon)
    return I18n.t('coupon.noexist') if coupon.nil?
    return I18n.t('coupon.cantactivate') if @order.order_items.blank?
    return I18n.t('coupon.sumerror') if @order.subtotal < coupon.min_sum_to_activate
    return I18n.t('coupon.termerror') if DateTime.now > coupon.expires
    true
  end
end

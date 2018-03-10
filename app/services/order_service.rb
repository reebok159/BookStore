class OrderService
  attr_reader :params, :user, :order

  def initialize(order)
    @order = order
  end

  def get_coupon(coupon_code)
    Coupon.find_by(code: coupon_code)
  end

  def activate_coupon(coupon)
    @order.coupon = coupon
    @order.save
  end

  def check_coupon_errors(coupon)
    return I18n.t('coupon.noexist') if coupon.nil?
    return I18n.t('coupon.cantactivate') if @order.order_items.blank?
    return I18n.t('coupon.sumerror') if @order.subtotal < coupon.min_sum_to_activate
    return I18n.t('coupon.termerror') if Time.now > coupon.expires
  end
end

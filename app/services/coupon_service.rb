class CouponService
  def initialize(order, coupon)
    @order = order
    @coupon = coupon
  end

  def check_coupon_errors
    return I18n.t('coupon.noexist') if @coupon.nil?
    return I18n.t('coupon.cantactivate') if @order.order_items.blank?
    return I18n.t('coupon.sumerror') if @order.subtotal < @coupon.min_sum_to_activate
    return I18n.t('coupon.termerror') if !@coupon.expires.nil? && Time.current > @coupon.expires
    return I18n.t('coupon.alreadyactivated') if @coupon.activated && @coupon.coupon_type == 'one_time'
  end
end

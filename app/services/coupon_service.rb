# frozen_string_literal: true

class CouponService
  def initialize(order, coupon)
    @order = order
    @coupon = coupon
  end

  def check_coupon_errors
    return I18n.t('coupon.noexist') if @coupon.nil?
    return I18n.t('coupon.cantactivate') if empty_order?
    return I18n.t('coupon.sumerror') if not_enough_sum?
    return I18n.t('coupon.termerror') if expired?
    return I18n.t('coupon.alreadyactivated') if already_activated?
  end

  private

  def already_activated?
    @coupon.activated && @coupon.coupon_type == 'one_time'
  end

  def expired?
    !@coupon.expires.nil? && Time.current > @coupon.expires
  end

  def empty_order?
    @order.order_items.blank?
  end

  def not_enough_sum?
    @order.subtotal < @coupon.min_sum_to_activate
  end
end

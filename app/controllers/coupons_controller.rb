# frozen_string_literal: true

class CouponsController < ApplicationController
  authorize_resource

  def create
    @coupon = Coupon.find_by(code: coupon_params[:code])
    errors = CouponService.new(last_order, @coupon).check_coupon_errors
    redirect_to(cart_page_url, alert: errors) && return if errors
    redirect_to cart_page_url, notice: t('coupon.activatesuccess') if last_order.update(coupon: @coupon)
  end

  def coupon_params
    params.require(:coupon).permit(:code)
  end
end

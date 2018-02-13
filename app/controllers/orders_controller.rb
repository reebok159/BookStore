class OrdersController < ApplicationController
  def index
    @cart = last_order
    @items = @cart.order_items.decorate
  end

  def activate_coupon
    service = OrderService.new(last_order)
    coupon = service.get_coupon(coupon_params[:coupon_id])
    msg = service.check_coupon_errors(coupon)
    if msg.nil?
      service.activate_coupon(coupon)
      msg = I18n.t('coupon.activatesuccess')
    end
    redirect_to cart_page_url, flash: { notice: msg }
  end

  private

  def coupon_params
    params.require(:order).permit(:coupon_id)
  end
end

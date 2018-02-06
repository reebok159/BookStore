class OrdersController < ApplicationController
  def index
    @cart = last_order
    @items = @cart.nil? ? [] : @cart.order_items.order(:id).decorate
    @coupon = @cart.coupon_discount
  end

  def activate_coupon
    service = OrderService.new(last_order)
    msg = service.activate_coupon(coupon_params[:coupon_id])
    msg = I18n.t('coupon.activatesuccess') if msg == :success
    flash[:notice] = msg
    redirect_to cart_page_url
  end

  private

  def coupon_params
    params.require(:order).permit(:coupon_id)
  end
end

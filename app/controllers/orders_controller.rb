class OrdersController < ApplicationController
  def index
    @cart = last_order
    @items = []
    @items = @cart.order_items.order(:id).decorate unless @cart.nil?

    @coupon = @cart.coupon_discount
  end

  def activate_coupon
    service = OrderService.new(last_order)
    flash[:notice] = service.activate_coupon(coupon_params[:coupon_id])
    redirect_to cart_page_url
  end

  private

  def coupon_params
    params.require(:order).permit(:coupon_id)
  end
end

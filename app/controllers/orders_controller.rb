class OrdersController < ApplicationController
  def index
    @cart = last_order
    @items = @cart.order_items.decorate
  end

  def activate_coupon
    service = OrderService.new(last_order)
    msg = service.save_coupon_with_message(coupon_params[:coupon_id])
    redirect_to cart_page_url, flash: { notice: msg }
  end

  private

  def coupon_params
    params.require(:order).permit(:coupon_id)
  end
end

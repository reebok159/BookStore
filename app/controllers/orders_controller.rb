class OrdersController < ApplicationController


  def index
    @cart = last_order
    @items = []
    @items = @cart.order_items.order(:id) unless @cart.nil?

    @subtotal = 0
    @coupon = 0

  end


  def cart_empty?
    true
  end


  def clear_cart
    cart = last_order.order_items

    if cart.clear
      flash[:notice] = 'Cart was cleared successfully'
    else
      flash[:notice] = 'Couldn\'t clear cart'
    end

    redirect_to request.referrer
  end

end

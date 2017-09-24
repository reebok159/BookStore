class OrdersController < ApplicationController


  def index
    @cart = last_order
    @items = []
    @items = @cart.order_items.order(:id) unless @cart.nil?

    @subtotal = 0
    @coupon = @cart.coupon.discount

  end


  def cart_empty?
    true
  end

  def activate_coupon
    coupon = Coupon.find_by(code: coupon_params[:coupon_id])

    if coupon.nil?
      flash[:notice] = "Coupon isn't exist"
    else
      if @cart.order_items.blank?
        flash[:notice] = "You cannot activate coupon"
      else
        @order = last_order

        #check if expires
        #check min summ

        @order.coupon = coupon
        @order.save
        flash[:notice] = "Coupon activated!"
      end
    end
    redirect_to cart_page_url
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

  private

    def coupon_params
      params.require(:order).permit(:coupon_id)
    end

end

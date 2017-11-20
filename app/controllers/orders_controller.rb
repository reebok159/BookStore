class OrdersController < ApplicationController
  def index
    @cart = last_order
    @items = []
    @items = @cart.order_items.order(:id).decorate unless @cart.nil?

    @coupon = @cart.coupon_discount
  end

  def activate_coupon
    coupon = Coupon.find_by(code: coupon_params[:coupon_id])

    if coupon.nil?
      flash[:notice] = t('coupon.noexist')
    else
      if last_order.order_items.blank?
        flash[:notice] = t('coupon.cantactivate')
      else
        @order = last_order
        if @order.subtotal < coupon.min_sum_to_activate
          flash[:notice] = t('coupon.sumerror')
        else
          if(DateTime.now > coupon.expires)
            flash[:notice] = t('coupon.termerror')
          else
            @order.coupon = coupon
            @order.save
            flash[:notice] = t('coupon.activatesuccess')
          end
        end
      end
    end
    redirect_to cart_page_url
  end

  private

  def coupon_params
    params.require(:order).permit(:coupon_id)
  end
end

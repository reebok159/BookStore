class OrderItemsController < ApplicationController

  def create
    order = last_order.order_items.build(order_items_params)

    if order.save
      flash[:notice] = 'Item was added to cart new'
    else
      flash[:notice] = 'Couldn\'t add item to cart'
    end

    redirect_to request.referrer
  end


  private

  def order_items_params
    params[:quantity] = 1 if params[:quantity].nil?
    params.permit(:item_id, :quantity)
  end
end

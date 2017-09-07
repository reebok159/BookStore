class OrderItemsController < ApplicationController

  def create
    #pry
    order = last_order.order_items.build(order_item_params)

    if order.save
      flash[:notice] = 'Item was added to cart new'
    else
      flash[:notice] = 'Couldn\'t add item to cart'
    end

    redirect_to request.referrer
  end

  def update
    item = last_order.order_items.find(params[:id])

    unless item.update_attributes(order_item_params)
      flash[:alert] = 'Couldn\'t update item'
    end

    redirect_to request.referrer
  end


  def destroy
    cart = last_order.order_items

    if(params[:id] == :all)
      if cart.delete(:all)
        flash[:notice] = 'Cart was cleared successfully'
      else
        flash[:notice] = 'Couldn\'t clear cart'
      end
    else
      cart.delete(params[:id])
    end

    redirect_to request.referrer
  end

  private

  def order_item_params
    params[:quantity] = 1 if params[:quantity].to_i <= 0
    params.permit(:item_id, :quantity)
  end
end

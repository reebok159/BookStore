class OrderItemsController < ApplicationController
  def create
    if order = last_order.order_items.find_by(item_id: params[:item_id])
      order.quantity += quantity_param(params[:quantity])
    else
      order = last_order.order_items.build(order_item_params)
    end

    if order.save
      flash[:notice] = 'Item was added to cart'
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

  def quantity_param(quantity)
    return 1 if quantity.to_i <= 0
    quantity.to_i
  end

  def order_item_params
    params[:quantity] = quantity_param(params[:quantity])
    params.permit(:item_id, :quantity)
  end
end

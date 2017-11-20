class OrderItemsController < ApplicationController
  def create
    if item = last_order.order_items.find_by(item_id: params[:item_id])
      item.increment(:quantity, quantity_param(params[:quantity]))
    else
      item = last_order.order_items.build(order_item_params)
    end

    if item.save
      flash[:notice] = t('order_item.create_success')
    else
      flash[:notice] = t('order_item.create_fail')
    end

    redirect_back(fallback_location: root_path)
  end

  def update
    item = last_order.order_items.find_by(id: params[:id])

    unless item&.update_attributes(order_item_params)
      flash[:alert] = t('order_item.update_fail')
    end

    redirect_back(fallback_location: root_path)
  end


  def destroy
    cart = last_order.order_items
    cart.destroy(params[:id])
    redirect_back(fallback_location: root_path)
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

class OrderItemsController < ApplicationController
  def create
    if item = last_order.order_items.find_by(item_id: filtered_params[:item_id])
      item.increment(:quantity, filtered_params[:quantity])
    else
      item = last_order.order_items.build(filtered_params)
    end
    flash[:notice] = item.save ? t('order_item.create_success') : t('order_item.create_fail')
    redirect_back(fallback_location: root_path)
  end

  def update
    item = last_order.order_items.find_by(id: params[:id])
    unless item&.update_attributes(filtered_params)
      flash[:alert] = t('order_item.update_fail')
    end
    redirect_back(fallback_location: root_path)
  end


  def destroy
    cart = last_order.order_items
    cart.destroy(params[:id]) if cart.exists?(params[:id])
    redirect_back(fallback_location: root_path)
  end

  private

  def quantity_param(quantity)
    quantity.to_i <= 0 ? 1 : quantity.to_i
  end

  def filtered_params
    filtered = order_item_params
    filtered[:quantity] = quantity_param(filtered[:quantity])
    filtered
  end

  def order_item_params
    params.require(:order_item).permit(:id, :item_id, :quantity)
  end
end

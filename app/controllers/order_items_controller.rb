class OrderItemsController < ApplicationController
  authorize_resource

  def create
    item = find_order_item
    if item
      item.increment(:quantity, filtered_params[:quantity])
    else
      item = last_order.order_items.build(filtered_params)
    end
    flash[:notice] = item.save ? t('order_item.create_success') : t('order_item.create_fail')
    redirect_back(fallback_location: root_path)
  end

  def update
    item = last_order.order_items.find_by(id: params[:id])
    flash[:alert] = t('order_item.update_fail') unless item&.update_attributes(filtered_params)
    redirect_back(fallback_location: root_path)
  end

  def destroy
    cart = last_order.order_items
    cart.destroy(params[:id]) if cart.exists?(params[:id])
    redirect_back(fallback_location: root_path)
  end

  private

  def find_order_item
    last_order.order_items.find_by(book_id: filtered_params[:book_id])
  end

  def quantity_param
    order_item_params[:quantity].to_i <= 0 ? 1 : order_item_params[:quantity].to_i
  end

  def filtered_params
    filtered_quantity = quantity_param
    order_item_params.merge(quantity: filtered_quantity)
  end

  def order_item_params
    params.require(:order_item).permit(:id, :book_id, :quantity)
  end
end

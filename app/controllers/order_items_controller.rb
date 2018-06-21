class OrderItemsController < ApplicationController
  load_and_authorize_resource find_by: :id

  def create
    item = last_order.order_items.find_or_initialize_by(book_id: filtered_params[:book_id])
    item.increment(:quantity, filtered_params[:quantity])
    flash[:notice] = item.save ? t('order_item.create_success') : t('order_item.create_fail')
    redirect_back(fallback_location: root_path)
  end

  def update
    flash[:alert] = t('order_item.update_fail') unless @order_item&.update(filtered_params)
    redirect_back(fallback_location: root_path)
  end

  def destroy
    cart = last_order.order_items
    cart.destroy(params[:id]) if cart.exists?(params[:id])
    redirect_back(fallback_location: root_path)
  end

  private

  def quantity_param
    order_item_params[:quantity].to_i <= 0 ? 1 : order_item_params[:quantity].to_i
  end

  def filtered_params
    order_item_params.merge(quantity: quantity_param)
  end

  def order_item_params
    params.require(:order_item).permit(:id, :book_id, :quantity)
  end
end

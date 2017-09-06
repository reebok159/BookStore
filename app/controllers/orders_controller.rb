class OrdersController < ApplicationController


  def cart
    @cart = last_order
    @books = @cart.order_items
  end

=begin
  def to_cart
    quantity = 1
    book = Book.find(params[:item_id])
    quantity = params[:quantity] if params[:quantity].to_i > 0

    if book
      item = [book.id, quantity]
      to_list(item)

      redirect_to request.referrer, notice: 'Item was added to cart 1'
    end
  end
=end
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

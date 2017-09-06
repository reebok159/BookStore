class OrdersController < ApplicationController

  before_action :get_items, :last_order

  def cart

  end

  def last_order
    if current_user.nil?
      create_order
      #get order from db by cookie order id
      Order.find_by(id: cookies.signed[:order_id], status: :in_progress)
    else
      order = current_user.users.find_by(status: :in_progress)
      if order.nil?
        current_user.orders.create
      else
        order
      end
    end
  end

  def create_order
    if current_user.nil? && !cookies[:order_id]
      order = Order.create
      cookies.signed[:order_id] = order
    end
  end

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

  def clear_cart
    @cart = nil
    save_items
    redirect_to request.referrer, notice: 'Cart was cleared successfully'
  end

  private

  def to_list(item)
    if current_user.nil?
      @cart << item
    else
      #add orderitem to order
    end

    save_items
  end

  def get_items
    @cart = []
    if current_user.nil?
      @cart = cookies.signed[:cart] unless cookies.signed[:cart].nil?
    else
      unless cookies.signed[:cart].nil?
        #order
      end
      #get from db
    end
  end

  def save_items
    if current_user.nil?
      cookies.signed[:cart] = @cart
    else
      #save to db
    end
  end


end

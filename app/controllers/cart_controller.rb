class CartController < ApplicationController
=begin
  def list
    get_list
  end

  def get_list
    @list = []
    @list = session[:cart] unless session[:cart].nil?
  end

  def to_cart
    get_list
    count = 1
    book = Book.find(params[:item_id])
    count = params[:count] if params[:count].to_i > 0

    if book
      item = [book.id, count]
      to_list(item)
      redirect_to request.referrer, notice: 'Item was added to cart'
    end

  end

  private
  def to_list(item)
    get_list
    @list << item
    save_list
  end

  def save_list
    session[:cart] = @list
  end

  #def item_validate
  #  params()
  #end
=end
end

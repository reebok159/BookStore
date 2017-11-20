class BooksController < ApplicationController

  def index
    @books = Book.where(select_category)
                 .order(sort_items)
                 .page(params[:page])
                 .per(12)
                 .decorate

    respond_to do |format|
      format.html
      format.js
    end
  end

  def select_category
    return { category_id: params[:catid] } unless params[:catid].nil?
    nil
  end

  SORT_PARAMS = {
    "newest" => { created_at: :desc },
    "popular" => { created_at: :asc },
    "lowprice" => { price: :asc },
    "highprice" => { price: :desc }
  }

  def sort_items
    SORT_PARAMS[params[:order].to_s]
  end

  def catalog
    message = "#{t('mainpage.welcome1')} #{t('mainpage.welcome2')}"
    redirect_to books_url, notice: message
  end

  def show
    @book = Book.find(params[:id]).decorate
    @review = Review.new
    @reviews = @book.reviews.accepted
  end
end

class BooksController < ApplicationController
  def index
    @books = Book
    unless params[:catid].nil?
      @books = @books.where(category_id: params[:catid])
    end
    unless params[:order].nil?
      case params[:order]
      when "newest"
        @books = @books.order('created_at DESC')
      when "popular"
        @books = @books.order('created_at ASC')
      when "lowprice"
        @books = @books.order('price ASC')
      when "highprice"
        @books = @books.order('price DESC')
      end
    end

    @books = @books.page(params[:page]).per(12)

    respond_to do |format|
      format.html
      format.js
    end
  end

  def catalog
    redirect_to books_url, notice: t('mainpage.welcome1')+' '+t('mainpage.welcome2')
  end

  def show
    @book = Book.find(params[:id])
    @review = Review.new
  end
end

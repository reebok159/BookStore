class BooksController < ApplicationController
  load_resource

  def index
    @books = Book.select_category(params[:category])
                 .select_sort(params[:sort])
                 .page(params[:page])
                 .per(Book::BOOKS_PER_PAGE)
                 .decorate
  end

  def show
    @book = @book.decorate
    @review = Review.new
    @reviews = @book.reviews.accepted.decorate
  end

  def catalog
    message = "#{t('mainpage.welcome1')} #{t('mainpage.welcome2')}"
    redirect_to books_url, notice: message
  end
end

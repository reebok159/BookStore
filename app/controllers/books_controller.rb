class BooksController < ApplicationController
  load_and_authorize_resource

  def index
    @books = Book.select_category(params[:category])
                 .select_sort(params[:sort])
                 .page(params[:page])
                 .decorate
  end

  def show
    #binding.pry
    @book = @book.decorate
    @reviews = @book.reviews.accepted.decorate
  end
end

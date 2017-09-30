class PagesController < ApplicationController
  def index
    @books_slider = get_latest
    @bestsellers = Book.bestsellers
  end

  def spry
    pry
  end


  private

    def get_latest(count = 2)
      @book = Book.last(count)
    end
end

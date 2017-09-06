class PagesController < ApplicationController
  def index
    @books_slider = get_latest
    @bestsellers = get_bestsellers
  end

  def spry
    pry
  end


  private

    def get_bestsellers(count = 4)
      #best = Book.select('books.*, COUNT(order_items.item_id) as count_books').left_outer_joins(:order_items).group('books.id').order('count_books DESC').first(count).to_sql
      #puts best
      best = Book.first(count)
      best
    end

    def get_latest(count = 2)
      @book = Book.last(count)
    end
end

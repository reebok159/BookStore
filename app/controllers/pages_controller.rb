class PagesController < ApplicationController

  def index
    @latest = BookDecorator.decorate_collection(get_latest)
    @bestsellers = BookDecorator.decorate_collection(Book.bestsellers)
  end

  def spry
    pry
  end

  private

  def get_latest(count = 2)
    Book.last(count)
  end
end

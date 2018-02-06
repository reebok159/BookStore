class PagesController < ApplicationController

  def index
    @latest = BookDecorator.decorate_collection(Book.latest)
    @bestsellers = BookDecorator.decorate_collection(Book.bestsellers)
  end

  def spry
    pry
  end

end

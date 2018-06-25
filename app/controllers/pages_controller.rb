# frozen_string_literal: true

class PagesController < ApplicationController
  def index
    @latest = BookDecorator.decorate_collection(Book.latest)
    @bestsellers = BookDecorator.decorate_collection(Book.bestsellers)
  end
end

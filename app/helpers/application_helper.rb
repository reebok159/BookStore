# frozen_string_literal: true

module ApplicationHelper
  def price_options
    { unit: '$', format: '%n%u' }
  end

  def categories_list
    Category.includes(:books).select(:id, :name).map do |category|
      { id: category.id, name: category.name, count_books: category.books.size }
    end
  end
end

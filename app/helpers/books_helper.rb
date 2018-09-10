# frozen_string_literal: true

module BooksHelper
  def selected_sort
    selected = params[:sort].to_s
    Book::SORT_PARAMS.key?(selected) ? I18n.t("books.#{selected}") : I18n.t("books.#{Book::DEFAULT_SORT}")
  end

  def sort_params
    Book::SORT_PARAMS.keys
  end

  def total_books
    @total_books ||= Book.all.size
  end
end

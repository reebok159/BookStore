module BooksHelper
  def get_selected_sort
    selected = params[:sort].to_s
    return I18n.t("books.#{selected}") if Book::SORT_PARAMS.key?(selected)
    I18n.t('books.newest')
  end

  def sort_params
    Book::SORT_PARAMS.keys
  end

  def total_books
    Book.all.size
  end
end

module BooksHelper
  def get_selected_sort
    selected = params[:sort].to_s
    return I18n.t("books.#{selected}") if Book::SORT_PARAMS.key?(selected)
    I18n.t('books.newest')
  end

  def sort_params
    Book::SORT_PARAMS.keys
  end

  def categories_list_with_count
    cats = Category.all
    cats_list = [general_category]
    cats.each do |item|
      cats_list << {
        path: books_path(category: item),
        name: item.name,
        total_books: item.books.size
      }
    end
    cats_list
  end

  private

  def general_category
    total_books = Book.all.count
    { path: books_path, name: I18n.t('books.all'), total_books: total_books }
  end
end

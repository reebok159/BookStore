module ApplicationHelper
  def price_options
    { unit: '$', format: "%n%u" }
  end

  def categories_list
    cats = Category.all
    cats_list = []
    cats.each do |item|
      cats_list << { path: books_path(category: item), name: item.name }
    end
    cats_list
  end
end

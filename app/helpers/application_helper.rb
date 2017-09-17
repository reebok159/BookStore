module ApplicationHelper

  CRITERIA_FOR_SORT = {
    :newest => 'Newest first',
    :popular => 'Popular first',
    :lowprice => 'Price: Low to high',
    :highprice => 'Price: High to low'
  }

  def price_format(summ)
    #{}"€#{summ}"
    "#{summ}$"
  end

  def categories_list
    cats = Category.all
    cats_list = []
    cats.each do |item|
      cats_list << { :path => books_path + "/catid/#{item.id}", :name => item.name }
    end
    cats_list
  end

  def authors_to_list(authors)
    return "" if authors.nil?
    authors.pluck(:name).join(', ')
  end

  def get_selected_sort
    return false if params[:order].nil? or !(params[:order].to_sym).in?(CRITERIA_FOR_SORT)
    CRITERIA_FOR_SORT[params[:order].to_sym]
  end

  def build_filter_url(criteria = nil)
    path = books_path
    path += "/catid/#{params[:catid]}" unless params[:catid].nil?
    path += "/order/#{criteria}" unless criteria.nil?
    path
  end

  def try_image(book, type = {})
    #@b = book
    #pry
    if book.images.empty?
      '/uploads/noimage.png'
    else
      book.images[0].image.url(type)
    end


  end

  def cart_empty?
    true
  end



end

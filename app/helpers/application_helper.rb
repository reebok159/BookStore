module ApplicationHelper

  CRITERIA_FOR_SORT = {
    :newest => 'Newest first',
    :popular => 'Popular first',
    :lowprice => 'Price: Low to high',
    :highprice => 'Price: High to low'
  }


  def categories_list
    cats = Category.all
    cats_list = []
    cats.each do |item|
      cats_list << { :path => books_path + "/catid/#{item.id}", :name => item.title }
    end
    cats_list
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

  def cart_empty?
    true
  end



end

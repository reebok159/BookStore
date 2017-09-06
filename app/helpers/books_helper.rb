module BooksHelper

  def cutted_desc(desc, max_length = 305)
    return '-' if desc.nil?
    if(desc.length > max_length)
      parts = [desc[0, max_length], desc[max_length + 1, desc.length - 1]]
      return capture_haml :div do
        haml_concat parts[0]
        haml_tag :span, '...', :class => "full_txt_dots"
        haml_tag :a, 'Read More', {:class => "in-gold-500 ml-10", :href => "#"}
        haml_tag :span, parts[1], {:class => "full_txt", :style => "display: none" }
      end
    end
    return desc
  end

  def year_published(published)
    "-"
  end

  def categories_list_with_count
    cats = Category.all
    cats_list = [get_all_for_cat(cats)]
    cats.each do |item|
      total_books = 0
      total_books = item.books.count unless item.books.count.nil?
      cats_list << { :path => books_path + "/catid/#{item.id}", :name => item.title, :total_books => total_books }
    end
    cats_list
  end

  private

    def get_all_for_cat(cats)
      total_books = 0
      cats.each { |item| total_books += item.books.count unless item.books.count.nil?}
      { :path => books_path, :name => 'All', :total_books => total_books}
    end

end

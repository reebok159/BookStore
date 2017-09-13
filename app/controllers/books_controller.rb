class BooksController < ApplicationController
  def index

    @books = Book
    unless params[:catid].nil?
      @books = @books.where(category_id: params[:catid])
    end
    unless params[:order].nil?
      case params[:order]
      when "newest"
        @books = @books.order('created_at DESC')
      when "popular"
        @books = @books.order('created_at ASC')
      when "lowprice"
        @books = @books.order('price ASC')
      when "highprice"
        @books = @books.order('price DESC')
      end
    end

    @books = @books.first(12)
    #pry
  end

  def catalog
    redirect_to books_url, notice: 'Welcome to our amazing Bookstore! We pore through hundreds of new books each month and select the five best to share with our members'
  end

  def show
    @book = Book.find(params[:id])
    pry
  end

  def new
    @book = Book.new
    @book.build_info_book
    @book.build_category
    @book.images.build
  end

  def create

    @book = Book.new(post_params)
    @category = Category.new(category_params)
    #pry
    if @category.valid?
      @category.save
      #pry
      @book.category_id = @category.id
    end

    #pry

    if @book.save
      #params[:images]['image'].each do |a|
      #  @book.images.create!(:image => a)
      #end

      redirect_to @book
    else
      render "new"
    end

  end

  def edit

    @book = Book.find(params[:id])
    #@category = @book.category || @book.build_category
    @info_book = @book.info_book || @book.build_info_book
    #@images = @book.images || @book.images.build
    #pry
    #@images = @book.images || @book.images.build
  end

  def update
    @book = Book.find(params[:id])
    if @book.update_attributes(post_params)
      redirect_to @book
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    #pry
    @book = Book.find(params[:id]).destroy
    redirect_to books_url, notice: 'Book was deleted'
  end

  private
  #
    def post_params
      params.require(:book).permit(:name, :price, :short_desc, :category_id, images_attributes: [:image, :_destroy, :id],
        info_book_attributes: [:width, :height, :depth, :full_desc, :published, :materials, :quantity])
    end

    def category_params
      params.require(:category).permit(:title)
    end

end

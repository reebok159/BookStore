class BookDecorator < Draper::Decorator
  delegate_all

  def self.collection_decorator_class
    PaginatingDecorator
  end

  def cover(type)
    return '/uploads/noimage.png' if object.images.empty?
    object.images.first.image.url(type)
  end

  def short_card_number
    "** ** ** #{credit_card.number.last(4)}"
  end

  def authors_list
    return '' if object.authors.nil?
    object.authors.pluck(:name).join(', ')
  end

  def sizes
    width = object.width.nil? ? "-" : object.width
    height = object.height.nil? ? "-" : object.height
    depth = object.depth.nil? ? "-" : object.depth

    "H: #{width} x W: #{height} x D: #{depth}"
  end
end

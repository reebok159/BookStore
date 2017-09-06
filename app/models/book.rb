class Book < ApplicationRecord
  #has_many :orders
  #has_and_belongs_to_many :authors
  belongs_to :order_item
  has_one :info_book
  accepts_nested_attributes_for :info_book
  belongs_to :category
  #accepts_nested_attributes_for :category

  def authors
    "Bass Jobsen, David Cochran, Ian Whitley"
  end

  #305 - size of text

end

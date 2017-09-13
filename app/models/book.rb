class Book < ApplicationRecord
  #has_many :orders
  #has_and_belongs_to_many :authors
  belongs_to :order_item, optional: true
  has_one :info_book, dependent: :destroy
  accepts_nested_attributes_for :info_book
  belongs_to :category
  #accepts_nested_attributes_for :category
  has_many :images, as: :imageable, dependent: :destroy

  accepts_nested_attributes_for :images, allow_destroy: true, :reject_if => proc { |attributes| attributes['image'].blank? }

  def authors
    "Bass Jobsen, David Cochran, Ian Whitley"
  end

  #305 - size of text

end

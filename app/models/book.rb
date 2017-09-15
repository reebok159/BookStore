class Book < ApplicationRecord
  #has_many :orders

  belongs_to :order_item, optional: true
  has_one :info_book, dependent: :destroy
  accepts_nested_attributes_for :info_book
  belongs_to :category, optional: true
  #accepts_nested_attributes_for :category
  has_many :images, as: :imageable, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true, :reject_if => proc { |att| att['image'].blank? }

  has_and_belongs_to_many :authors
  #accepts_nested_attributes_for :authors, allow_destroy: true, :reject_if => proc { |att| att['name'].blank? }



  #305 - size of text

end

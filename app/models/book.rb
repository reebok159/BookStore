class Book < ApplicationRecord
  #has_many :orders
  has_many :order_items, foreign_key: "item_id"
  has_many :orders, through: :order_items#, optional: true

  has_one :info_book, dependent: :destroy
  accepts_nested_attributes_for :info_book

  belongs_to :category, optional: true
  #accepts_nested_attributes_for :category

  has_many :images, as: :imageable, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true, :reject_if => proc { |att| att['image'].blank? }

  has_and_belongs_to_many :authors

  validates :name, :price, presence: true

end

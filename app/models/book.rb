class Book < ApplicationRecord
  #has_many :orders
  has_many :order_items, foreign_key: "item_id", dependent: :destroy
  has_many :orders, through: :order_items#, optional: true
  has_many :reviews, dependent: :destroy
  accepts_nested_attributes_for :reviews

  has_one :info_book, dependent: :destroy
  accepts_nested_attributes_for :info_book

  belongs_to :category, optional: true
  #accepts_nested_attributes_for :category

  has_many :images, as: :imageable, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true, :reject_if => proc { |att| att['image'].blank? }

  has_and_belongs_to_many :authors

  validates :name, :price, presence: true

  scope :bestsellers, -> {
    find_by_sql("SELECT books.*
    FROM books
    LEFT OUTER JOIN order_items ON order_items.item_id = books.id
    LEFT OUTER JOIN orders ON orders.id = order_items.order_id AND orders.status != 0
    GROUP BY books.id
    ORDER BY COUNT(order_items.item_id) DESC
    LIMIT 4")
  }

end

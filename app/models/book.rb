class Book < ApplicationRecord
  has_many :order_items, foreign_key: "item_id", dependent: :destroy
  has_many :orders, through: :order_items
  has_many :reviews, dependent: :destroy
  has_many :images, as: :imageable, dependent: :destroy
  has_and_belongs_to_many :authors
  belongs_to :category, optional: true

  MAX_FULL_DESC_SHOW = 300
  BOOKS_PER_PAGE = 12

  SORT_PARAMS = {
    "newest" => { created_at: :desc },
    "popular" => { created_at: :asc },
    "lowprice" => { price: :asc },
    "highprice" => { price: :desc }
  }

  validates :name, :price, presence: true

  scope :bestsellers, -> (num = 4) {
    find_by_sql(["SELECT books.* FROM order_items AS oi
      INNER JOIN orders ON orders.id = oi.order_id AND orders.status != 0
      RIGHT OUTER JOIN books ON books.id = oi.item_id
      GROUP BY books.id
      ORDER BY COUNT(oi.item_id) DESC
      LIMIT ?", num])
  }

  scope :latest, -> (num = 2) { last(num) }
  scope :select_category, ->(cat = nil) { where(category: cat) unless cat.nil? }
  scope :select_sort, -> (val = nil) { order(SORT_PARAMS[val]) if SORT_PARAMS.key?(val) }
end

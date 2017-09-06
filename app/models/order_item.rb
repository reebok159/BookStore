class OrderItem < ApplicationRecord
  belongs_to :order
  has_one :book, primary_key: "item_id", foreign_key: "id"
end

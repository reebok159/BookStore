class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :book, primary_key: "id", foreign_key: "item_id"
end

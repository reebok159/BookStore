class OrderItem < ApplicationRecord
  belongs_to :order
  has_one :book, :foreign_key => "item_id"
end

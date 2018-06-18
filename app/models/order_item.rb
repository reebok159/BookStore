class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :book

  validates :quantity, numericality: { greater_than_or_equal_to: 0 }

  after_destroy do |item|
    item&.order&.check_need_coupon
  end
end

class DeliveryMethod < ApplicationRecord
  has_many :orders
  validates :name, :cost, :delay, presence: true

  default_scope { order(:cost) }
end

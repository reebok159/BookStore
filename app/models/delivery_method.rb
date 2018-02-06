class DeliveryMethod < ApplicationRecord
  has_many :orders, dependent: :nullify
  validates :name, :cost, :delay, presence: true
end

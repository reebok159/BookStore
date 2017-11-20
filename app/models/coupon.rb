class Coupon < ApplicationRecord
  has_many :orders, dependent: :nullify
end

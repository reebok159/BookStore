class Coupon < ApplicationRecord
  has_many :orders, dependent: :nullify
  validates :code, presence: true, uniqueness: true
  validates :discount, presence: true

  enum coupon_type: %i[reusable one_time]
end

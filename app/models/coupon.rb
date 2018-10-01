# frozen_string_literal: true

class Coupon < ApplicationRecord
  enum coupon_type: %i[reusable one_time]

  has_many :orders, dependent: :nullify

  validates :code, presence: true, uniqueness: true
  validates :discount, presence: true

  def deactivate
    update(activated: true) if coupon_type == 'one_time'
  end
end

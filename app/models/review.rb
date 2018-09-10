# frozen_string_literal: true

class Review < ApplicationRecord
  REVIEW_TITLE_REGEX = Regexp.new('\A[0-9A-z!#$%&\'\-*,+=?^_`{|}~. ]+\z')
  MAX_RATING = 5

  enum status: %i[unprocessed approved rejected]

  belongs_to :user
  belongs_to :book

  validates :title, :text, :rating, presence: true
  validates :title, :text, format: { with: REVIEW_TITLE_REGEX }
  validates :title, length: { maximum: 80 }
  validates :text, length: { maximum: 1000 }
  validates :rating, inclusion: { in: 1..5 }

  def verified?
    OrderItem.where(
      order_id: user.orders.delivered.ids
    ).exists?
  end
end

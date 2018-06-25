# frozen_string_literal: true

class Review < ApplicationRecord
  enum status: %i[unprocessed approved rejected]

  belongs_to :user
  belongs_to :book

  validates :title, :text, :rating, presence: true
  validates :title, :text, format: { with: /\A[0-9A-z!#$%&'\-*,+=?^_`{|}~. ]+\z/ }
  validates :title, length: { maximum: 80 }
  validates :text, length: { maximum: 1000 }
  validates :rating, inclusion: { in: 1..5 }
end

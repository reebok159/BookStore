class Review < ApplicationRecord

  belongs_to :user
  belongs_to :book

  validates :title, :text, :rating, presence: true

  scope :accepted, -> { where(accepted: true) }
end

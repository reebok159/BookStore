class Review < ApplicationRecord

  belongs_to :user
  belongs_to :book

  scope :accepted, -> { where(:accepted => true) }
end

class Category < ApplicationRecord
  has_many :books

  validates :title, {presence: true, length: { in: 2..20 }}
end

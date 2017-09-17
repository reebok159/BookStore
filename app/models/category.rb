class Category < ApplicationRecord
  has_many :books

  validates :name, {presence: true, length: { in: 2..20 }, uniqueness: true}
end

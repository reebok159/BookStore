class Author < ApplicationRecord
  has_and_belongs_to_many :book

  validates :name, { presence: true, uniqueness: true }
end

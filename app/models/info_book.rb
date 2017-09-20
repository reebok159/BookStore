class InfoBook < ApplicationRecord
  belongs_to :book, optional: true
end

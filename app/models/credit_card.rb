class CreditCard < ApplicationRecord
  validates :number, :name, :expires, :cvv, presence: true
  validates :number, format: { with: %r{\A\d{16}\z} }
  validates :name, format: { with: %r{\A[a-zA-Z\s]{0,49}\z} }
  validates :expires, format: { with: %r{\A(0[1-9]|10|11|12)\/\d\d\z} }
  validates :cvv, numericality: { only_integer: true }, format: { with: /\A[0-9]{3,4}\z/ }

  belongs_to :order
end

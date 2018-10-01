# frozen_string_literal: true

class CreditCard < ApplicationRecord
  include ActiveModel::Validations

  CARD_NAME_REGEX = Regexp.new('\A[a-zA-Z\s]+\z')
  CARD_EXPIRES_REGEX = Regexp.new('\A(0[1-9]|10|11|12)\/\d\d\z')

  belongs_to :order

  validates_with CreditCardValidator
  validates :number, :name, :expires, :cvv, presence: true
  validates :number, length: { is: 16 }, numericality: { only_integer: true }
  validates :name, length: { in: 2..49 }, format: { with: CARD_NAME_REGEX }
  validates :expires, format: { with: CARD_EXPIRES_REGEX }
  validates :cvv, length: { is: 3 }, numericality: { only_integer: true }
end

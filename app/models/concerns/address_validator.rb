# frozen_string_literal: true

module AddressValidator
  extend ActiveSupport::Concern

  PHONE_REGEX = Regexp.new('\A[+][\d]+\z')
  ZIP_REGEX = Regexp.new('\A([\d]\-?)+\z')
  CITY_REGEX = Regexp.new('\A([a-zA-Z\s])+\z')
  ADDRESS_REGEX = Regexp.new('\A([a-zA-Z\s\d][\,\-]?)+\z')
  LAST_NAME_REGEX = Regexp.new('\A([a-zA-Z])+\z')

  included do
    validates :first_name, :last_name, :address, :city, :zip, :country, :phone, presence: true

    validates :phone, length: { in: 6..15 }, format: { with: PHONE_REGEX }
    validates :zip, length: { in: 3..10 }, format: { with: ZIP_REGEX }
    validates :city, length: { in: 2..50 }, format: { with: CITY_REGEX }
    validates :address, length: { in: 2..50 }, format: { with: ADDRESS_REGEX }
    validates :last_name, :first_name, length: { in: 2..50 }, format: { with: LAST_NAME_REGEX }
  end
end

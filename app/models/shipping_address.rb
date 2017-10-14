class ShippingAddress < ApplicationRecord
  belongs_to :user
  validates :first_name, :last_name, :address, :city, :zip, :country, :phone, presence: true

  validates :phone, format: { with: %r{\A[+][0-9]{6,15}\z} }
  validates :zip, format: { with: %r{\A([0-9]\-?){3,10}\z} }
  validates :city, format: { with: %r{\A([a-zA-Z\s]){2,50}\z} }
  validates :address, format: { with: %r{\A[-A-Za-z\s\d,]{0,49}\z} }
  validates :last_name, :first_name, format: { with: %r{\A([a-zA-Z]){2,50}\z} }
end

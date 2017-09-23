class BillingAddress < ApplicationRecord
  belongs_to :user
  validates :first_name, :last_name, :address, :city, :zip, :country, :phone, presence: true
end

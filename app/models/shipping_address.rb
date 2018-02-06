class ShippingAddress < ApplicationRecord
  belongs_to :shipping_a, polymorphic: true
  include AddressValidator
end

class BillingAddress < ApplicationRecord
  belongs_to :billing_a, polymorphic: true
  include AddressValidator
end

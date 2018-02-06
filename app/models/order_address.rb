class OrderAddress < ApplicationRecord
  belongs_to :order
  enum kind: %i[shipping billing]

  include AddressValidator
  validates_uniqueness_of :kind, scope: [:order_id]

end

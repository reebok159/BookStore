module AddressValidator
  extend ActiveSupport::Concern
  included do
    validates :first_name, :last_name, :address, :city, :zip, :country, :phone, presence: true

    validates :phone, length: { in: 6..15 }, format: { with: /\A[+][\d]+\z/ }
    validates :zip, length: { in: 3..10 }, format: { with: /\A([\d]\-?)+\z/ }
    validates :city, length: { in: 2..50 }, format: { with: /\A([a-zA-Z\s])+\z/ }
    validates :address, length: { in: 2..50 }, format: { with: /\A([a-zA-Z\s\d][\,\-]?)+\z/ }
    validates :last_name, :first_name, length: { in: 2..50 }, format: { with: /\A([a-zA-Z])+\z/ }
  end
end

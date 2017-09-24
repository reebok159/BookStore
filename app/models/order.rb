class Order < ApplicationRecord
  belongs_to :user, optional: true

  include AASM

  aasm column: 'checkout_state' do
    state :address, :initial => true
    state :delivery
    state :payment
    state :confirm
    state :complete

    event :next_state do
      transitions from: :address, to: :delivery
      transitions from: :delivery, to: :payment
      transitions from: :payment, to: :confirm
      transitions from: :confirm, to: :complete
    end
  end

  belongs_to :delivery_method, optional: true
  belongs_to :coupon, optional: true
  has_one :order_address, dependent: :destroy
  has_many :order_items
  has_many :books, through: :order_items

  has_one :credit_card, dependent: :destroy
  accepts_nested_attributes_for :credit_card

  enum status: [:in_progress, :in_queue, :in_delivery, :delivered, :canceled]

  def total_quantity
    order_items.pluck(:id).count
  end



end

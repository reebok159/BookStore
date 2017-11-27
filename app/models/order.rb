class Order < ApplicationRecord
  belongs_to :user, optional: true

  include AASM

  aasm column: 'checkout_state' do
    state :address, :initial => true
    state :delivery
    state :payment
    state :confirm
    state :complete

    event :reset_state do
      transitions to: :address
    end

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
  has_many :order_items, dependent: :destroy
  has_many :books, through: :order_items

  has_one :credit_card, dependent: :destroy
  accepts_nested_attributes_for :credit_card

  enum status: [:in_progress, :in_queue, :in_delivery, :delivered, :canceled]

  scope :completed, -> { where.not(status: :in_progress) }

  def total_quantity
    order_items.pluck(:quantity).sum
  end

  def coupon_discount
    return 0 if self.coupon.nil?
    self.coupon.discount
  end

  def subtotal
    order_items.collect { |item| item.quantity * item.book.price }.sum
  end

  def total_items
    self.subtotal - self.coupon_discount
  end

  def pre_total_price
    self.subtotal + self.delivery_price - self.coupon_discount
  end

  def delivery_price
    return 0 if self.delivery_method.nil?
    self.delivery_method.cost
  end



end

# frozen_string_literal: true

class Order < ApplicationRecord
  include AASM

  enum status: %i[in_progress in_queue in_delivery delivered canceled]

  belongs_to :user, optional: true
  belongs_to :delivery_method, optional: true
  belongs_to :coupon, optional: true
  has_one :billing_address, as: :billing_a, dependent: :destroy
  has_one :shipping_address, as: :shipping_a, dependent: :destroy
  has_one :credit_card, dependent: :destroy
  has_many :order_items, dependent: :destroy
  has_many :books, through: :order_items

  validates_associated :billing_address
  validates_associated :shipping_address
  validates_associated :credit_card

  scope :completed, -> { where.not(status: :in_progress) }
  scope :select_status, ->(val) { where(status: val) unless val.nil? }

  aasm column: 'checkout_state' do
    state :address, initial: true
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

  def total_quantity
    order_items.pluck(:quantity).sum
  end

  def subtotal
    order_items.collect { |item| item.quantity * item.book.price }.sum
  end

  def coupon_discount
    coupon.nil? ? 0 : coupon.discount
  end

  def delivery_price
    delivery_method&.cost || 0
  end

  def pre_total_price
    subtotal + delivery_price - coupon_discount
  end

  def check_need_coupon
    update(coupon: nil) if total_quantity.zero? && !coupon.nil?
  end
end

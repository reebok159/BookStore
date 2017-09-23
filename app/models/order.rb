class Order < ApplicationRecord
  belongs_to :user, optional: true

  has_many :order_items
  has_many :books, through: :order_items

  enum  status: [:in_progress, :in_queue, :in_delivery, :delivered, :canceled]

  def total_quantity
    #order_items.pluck(:quantity).sum
    order_items.pluck(:id).count
  end

end

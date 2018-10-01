# frozen_string_literal: true

FactoryBot.define do
  factory :order_item do
    order
    book nil
    quantity 1
  end
end

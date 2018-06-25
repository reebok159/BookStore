# frozen_string_literal: true

class OrderItemDecorator < Draper::Decorator
  decorates_association :book
  delegate_all
end

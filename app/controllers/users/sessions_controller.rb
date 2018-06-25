# frozen_string_literal: true

module Users
  class SessionsController < Devise::SessionsController
    def create
      save_cart unless current_user.nil?
      super
    end

    private

    def save_cart
      return unless guest_order
      guest_items = guest_order.order_items
      clear_guest_cookies
      return if guest_items.empty?
      user_items = last_order.order_items
      guest_items.find_each do |item|
        found_item = user_items.find_by(book_id: item.book_id)
        user_items.push(item) && next if found_item.nil?
        found_item.increment!(:quantity, item.quantity)
      end
    end
  end
end

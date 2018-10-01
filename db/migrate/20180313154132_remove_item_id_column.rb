# frozen_string_literal: true

class RemoveItemIdColumn < ActiveRecord::Migration[5.1]
  def change
    remove_column :order_items, :item_id
  end
end

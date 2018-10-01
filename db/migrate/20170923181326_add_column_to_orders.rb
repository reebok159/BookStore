# frozen_string_literal: true

class AddColumnToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :checkout_state, :string
  end
end

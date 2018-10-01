# frozen_string_literal: true

class AddColumnsToAddresses < ActiveRecord::Migration[5.1]
  def change
    add_column :shipping_addresses, :user_id, :integer
    add_column :billing_addresses, :user_id, :integer
  end
end

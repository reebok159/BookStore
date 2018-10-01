# frozen_string_literal: true

class AddCcolumnToORderAddress < ActiveRecord::Migration[5.1]
  def change
    add_column :order_addresses, :order_id, :integer
  end
end

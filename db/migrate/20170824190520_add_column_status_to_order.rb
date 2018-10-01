# frozen_string_literal: true

class AddColumnStatusToOrder < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :status, :integer, default: 0
  end
end

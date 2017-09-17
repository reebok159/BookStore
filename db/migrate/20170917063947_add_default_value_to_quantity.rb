class AddDefaultValueToQuantity < ActiveRecord::Migration[5.1]
  def change
    change_column :info_books, :quantity, :integer, :default => 1
  end
end

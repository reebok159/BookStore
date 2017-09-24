class AddColumnTotalPriceToOrder < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :total_price, :decimal, precision: 11, scale: 2, default: 0
    add_column :orders, :completed_at, :datetime
  end
end

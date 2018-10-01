class AddColumnToOrderItems < ActiveRecord::Migration[5.1]
  def change
    add_column :order_items, :price, :float, default: 0
    remove_column :billing_addresses, :user_id
    remove_column :shipping_addresses, :user_id
    change_column_default :books, :price, 0
  end
end

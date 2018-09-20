class DropShippingAndBillingAddresses < ActiveRecord::Migration[5.1]
  def change
    drop_table :shipping_addresses
    drop_table :billing_addresses
  end
end

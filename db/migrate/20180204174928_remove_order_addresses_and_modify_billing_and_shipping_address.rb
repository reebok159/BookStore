class RemoveOrderAddressesAndModifyBillingAndShippingAddress < ActiveRecord::Migration[5.1]
  def change
    drop_table :order_addresses
    change_table :billing_addresses do |t|
      t.references :billing_a, polymorphic: true, index: true
    end

    change_table :shipping_addresses do |t|
      t.references :shipping_a, polymorphic: true, index: true
    end
  end
end

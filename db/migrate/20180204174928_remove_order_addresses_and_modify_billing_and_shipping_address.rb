class RemoveOrderAddressesAndModifyBillingAndShippingAddress < ActiveRecord::Migration[5.1]
  def up
    drop_table :order_addresses
    change_table :billing_addresses do |t|
      t.references :billing_a, polymorphic: true, index: true
    end

    change_table :shipping_addresses do |t|
      t.references :shipping_a, polymorphic: true, index: true
    end
  end

  def down
    remove_reference :billing_addresses, :billing_a
    remove_reference :shipping_addresses, :shipping_a
    create_table :order_addresses do |t|
      t.string :billing_first_name
      t.string :billing_last_name
      t.string :billing_address
      t.string :billing_city
      t.string :billing_zip
      t.string :billing_country
      t.string :billing_phone
      t.string :shipping_first_name
      t.string :shipping_last_name
      t.string :shipping_address
      t.string :shipping_city
      t.string :shipping_zip
      t.string :shipping_country
      t.string :shipping_phone
      t.timestamps
    end
  end
end

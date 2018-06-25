# frozen_string_literal: true

class CreateOrderAddresses < ActiveRecord::Migration[5.1]
  def change
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

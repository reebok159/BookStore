# frozen_string_literal: true

class CreateBillingAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :billing_addresses do |t|
      t.text :first_name
      t.text :last_name
      t.text :address
      t.text :city
      t.text :zip
      t.text :country
      t.text :phone
      t.timestamps
    end
  end
end

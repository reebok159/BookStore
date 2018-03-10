class FixColumnsInAddresses < ActiveRecord::Migration[5.1]
  def change
    change_table :shipping_addresses do |t|
      t.change :first_name, :string
      t.change :last_name, :string
      t.change :address, :string
      t.change :city, :string
      t.change :zip, :string
      t.change :country, :string
      t.change :phone, :string
    end

    change_table :billing_addresses do |t|
      t.change :first_name, :string
      t.change :last_name, :string
      t.change :address, :string
      t.change :city, :string
      t.change :zip, :string
      t.change :country, :string
      t.change :phone, :string
    end
  end
end

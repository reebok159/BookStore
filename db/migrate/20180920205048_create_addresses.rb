class CreateAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :addresses do |t|
      t.text :first_name
      t.text :last_name
      t.text :address
      t.text :city
      t.text :zip
      t.text :country
      t.text :phone
      t.references :addressable, polymorphic: true, index: true

      t.timestamps
    end
  end
end

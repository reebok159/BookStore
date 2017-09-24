class CreateDeliveryMethods < ActiveRecord::Migration[5.1]
  def change
    create_table :delivery_methods do |t|
      t.string :name
      t.string :delay
      t.integer :cost
      t.timestamps
    end

    add_column :orders, :delivery_method_id, :integer
  end
end

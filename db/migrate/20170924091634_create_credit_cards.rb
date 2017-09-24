class CreateCreditCards < ActiveRecord::Migration[5.1]
  def change
    create_table :credit_cards do |t|
      t.string :number
      t.string :name
      t.string :expires
      t.string :cvv
      t.integer :order_id
      t.timestamps
    end
  end
end

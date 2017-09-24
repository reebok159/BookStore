class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.string :title
      t.string :text
      t.integer :rating
      t.integer :user_id
      t.integer :book_id
      t.string :status
      t.boolean :verified, :default => false
      t.timestamps
    end
  end
end

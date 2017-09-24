class ChangeReviewsTable < ActiveRecord::Migration[5.1]
  def change
    remove_column :reviews, :status
    add_column :reviews, :accepted, :boolean, :default => false
  end
end

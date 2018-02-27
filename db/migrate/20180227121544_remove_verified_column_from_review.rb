class RemoveVerifiedColumnFromReview < ActiveRecord::Migration[5.1]
  def change
    remove_column :reviews, :verified
  end
end

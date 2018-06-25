# frozen_string_literal: true

class RemoveVerifiedColumnFromReview < ActiveRecord::Migration[5.1]
  def change
    remove_column :reviews, :verified
  end
end

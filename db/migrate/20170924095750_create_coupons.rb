# frozen_string_literal: true

class CreateCoupons < ActiveRecord::Migration[5.1]
  def change
    create_table :coupons do |t|
      t.string :name
      t.string :discount
      t.float :min_sum_to_activate
      t.date :expires
      t.timestamps
    end
  end
end

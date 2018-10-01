# frozen_string_literal: true

class CreateInfoBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :info_books do |t|
      t.text :full_desc
      t.integer :quantity
      t.float :width
      t.float :height
      t.float :depth
      t.date :published
      t.string :materials

      t.timestamps
    end
  end
end

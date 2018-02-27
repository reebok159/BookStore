class MoveInfoBookColumnsToBookTable < ActiveRecord::Migration[5.1]
  def change
    drop_table :info_books
    add_column :books, :full_desc, :text
    add_column :books, :width, :integer
    add_column :books, :height, :integer
    add_column :books, :depth, :integer
    add_column :books, :published, :integer
    add_column :books, :materials, :string
  end
end

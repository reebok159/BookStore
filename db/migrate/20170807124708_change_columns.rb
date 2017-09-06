class ChangeColumns < ActiveRecord::Migration[5.1]
  def change
    remove_column :books, :info_book_id
    add_column :info_books, :book_id, :integer
  end
end

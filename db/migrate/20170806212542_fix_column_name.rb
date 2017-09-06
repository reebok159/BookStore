class FixColumnName < ActiveRecord::Migration[5.1]
  def change
    rename_column :books, :info_book, :info_book_id
  end
end

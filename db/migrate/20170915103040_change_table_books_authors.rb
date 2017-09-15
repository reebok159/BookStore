class ChangeTableBooksAuthors < ActiveRecord::Migration[5.1]
  def change
    drop_table :authors_books

    create_table :authors_books, id: false do |t|
      t.belongs_to :book, index: true
      t.belongs_to :author, index: true
    end
  end
end

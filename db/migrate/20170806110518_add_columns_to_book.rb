class AddColumnsToBook < ActiveRecord::Migration[5.1]
  def change
    add_column :books, :info_book, :integer
    add_column :books, :category_id, :integer
    create_table :books_authors, id: false do |t|
      t.belongs_to :book, index: true
      t.belongs_to :authors, index: true
    end
  end
end

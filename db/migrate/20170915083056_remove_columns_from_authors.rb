# frozen_string_literal: true

class RemoveColumnsFromAuthors < ActiveRecord::Migration[5.1]
  def change
    remove_column :authors, :first_name
    remove_column :authors, :last_name
    add_column :authors, :name, :string

    drop_table :books_authors

    create_table :books_authors, id: false do |t|
      t.belongs_to :book_id, index: true
      t.belongs_to :author_id, index: true
    end
  end
end

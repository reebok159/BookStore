# frozen_string_literal: true

class RenameTable < ActiveRecord::Migration[5.1]
  def change
    rename_table :books_authors, :authors_books
  end
end

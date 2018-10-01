# frozen_string_literal: true

class ChangeColunmYearOfPublication < ActiveRecord::Migration[5.1]
  def change
    remove_column :info_books, :published
    add_column :info_books, :published, :integer
  end
end

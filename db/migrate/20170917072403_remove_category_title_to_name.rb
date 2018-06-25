# frozen_string_literal: true

class RemoveCategoryTitleToName < ActiveRecord::Migration[5.1]
  def change
    rename_column :categories, :title, :name
  end
end

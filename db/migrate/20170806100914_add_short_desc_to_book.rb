class AddShortDescToBook < ActiveRecord::Migration[5.1]
  def change
    add_column :books, :short_desc, :text
  end
end

class ChangeNameColumnInImages < ActiveRecord::Migration[5.1]
  def change
    rename_column :images, :file, :image
  end
end

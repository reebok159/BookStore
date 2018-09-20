class AddColumnKindToAddress < ActiveRecord::Migration[5.1]
  def change
    change_table :addresses do |t|
      t.integer :kind, null: false
    end
  end
end

class FixColumnInCoupon < ActiveRecord::Migration[5.1]
  def change
    remove_column :coupons, :discount
    add_column :coupons, :discount, :float, :default => 0
  end
end

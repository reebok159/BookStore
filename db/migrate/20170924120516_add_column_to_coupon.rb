class AddColumnToCoupon < ActiveRecord::Migration[5.1]
  def change
    add_column :coupons, :code, :string
    add_column :orders, :coupon_id, :integer
  end
end

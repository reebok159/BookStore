class AddIndexesAndForeignKeys < ActiveRecord::Migration[5.1]
  def change
    drop_table :carts

    add_foreign_key :authors_books, :books
    add_foreign_key :authors_books, :authors

    add_foreign_key :billing_addresses, :users
    add_index :billing_addresses, :user_id

    add_foreign_key :books, :categories
    add_index :books, :category_id

    add_foreign_key :credit_cards, :orders
    add_index :credit_cards, :order_id

    add_foreign_key :info_books, :books
    add_index :info_books, :book_id

    add_foreign_key :order_addresses, :orders
    add_index :order_addresses, :order_id

    add_foreign_key :order_items, :orders
    add_foreign_key :order_items, :books, column: :item_id
    add_index :order_items, :order_id
    add_index :order_items, :item_id

    add_foreign_key :orders, :users
    add_foreign_key :orders, :delivery_methods
    add_foreign_key :orders, :coupons
    add_index :orders, :user_id
    add_index :orders, :delivery_method_id
    add_index :orders, :coupon_id

    add_foreign_key :reviews, :users
    add_foreign_key :reviews, :books
    add_index :reviews, :user_id
    add_index :reviews, :book_id

    add_foreign_key :shipping_addresses, :users
    add_index :shipping_addresses, :user_id
  end
end

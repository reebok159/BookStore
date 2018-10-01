# frozen_string_literal: true

class AddIndexesAndForeignKeys < ActiveRecord::Migration[5.1]
  def change
    change_table :books do |t|
      t.remove :category_id
      t.belongs_to :category, foreign_key: true, index: true
    end

    change_table :credit_cards do |t|
      t.remove :order_id
      t.belongs_to :order, foreign_key: true, index: true
    end

    change_table :order_items do |t|
      t.remove :order_id
      t.belongs_to :order, foreign_key: true, index: true
      t.belongs_to :book, column: :item_id, foreign_key: true, index: true
    end

    change_table :orders do |t|
      t.remove :user_id, :delivery_method_id, :coupon_id
      t.belongs_to :user, foreign_key: true, index: true
      t.belongs_to :delivery_method, foreign_key: true, index: true
      t.belongs_to :coupon, foreign_key: true, index: true
    end

    change_table :reviews do |t|
      t.remove :user_id, :book_id
      t.belongs_to :user, foreign_key: true, index: true
      t.belongs_to :book, foreign_key: true, index: true
    end
  end
end

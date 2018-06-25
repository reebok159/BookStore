# frozen_string_literal: true

class AddUseBillingColumn < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :use_billing, :boolean
  end
end

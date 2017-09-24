# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170924193723) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authors", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
  end

  create_table "authors_books", id: false, force: :cascade do |t|
    t.bigint "book_id"
    t.bigint "author_id"
    t.index ["author_id"], name: "index_authors_books_on_author_id"
    t.index ["book_id"], name: "index_authors_books_on_book_id"
  end

  create_table "billing_addresses", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "address"
    t.string "city"
    t.string "zip"
    t.string "country"
    t.string "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
  end

  create_table "books", force: :cascade do |t|
    t.string "name"
    t.float "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "short_desc"
    t.integer "category_id"
  end

  create_table "carts", force: :cascade do |t|
    t.integer "item_id"
    t.integer "count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "coupons", force: :cascade do |t|
    t.string "name"
    t.float "min_sum_to_activate"
    t.date "expires"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "code"
    t.float "discount", default: 0.0
  end

  create_table "credit_cards", force: :cascade do |t|
    t.string "number"
    t.string "name"
    t.string "expires"
    t.string "cvv"
    t.integer "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "delivery_methods", force: :cascade do |t|
    t.string "name"
    t.string "delay"
    t.integer "cost"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "images", force: :cascade do |t|
    t.string "imageable_type"
    t.bigint "imageable_id"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["imageable_type", "imageable_id"], name: "index_images_on_imageable_type_and_imageable_id"
  end

  create_table "info_books", force: :cascade do |t|
    t.text "full_desc"
    t.integer "quantity", default: 1
    t.float "width"
    t.float "height"
    t.float "depth"
    t.string "materials"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "book_id"
    t.integer "published"
  end

  create_table "order_addresses", force: :cascade do |t|
    t.string "billing_first_name"
    t.string "billing_last_name"
    t.string "billing_address"
    t.string "billing_city"
    t.string "billing_zip"
    t.string "billing_country"
    t.string "billing_phone"
    t.string "shipping_first_name"
    t.string "shipping_last_name"
    t.string "shipping_address"
    t.string "shipping_city"
    t.string "shipping_zip"
    t.string "shipping_country"
    t.string "shipping_phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "order_id"
  end

  create_table "order_items", force: :cascade do |t|
    t.integer "order_id"
    t.integer "item_id"
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0
    t.string "checkout_state"
    t.integer "delivery_method_id"
    t.integer "coupon_id"
    t.decimal "total_price", precision: 11, scale: 2, default: "0.0"
    t.datetime "completed_at"
  end

  create_table "reviews", force: :cascade do |t|
    t.string "title"
    t.string "text"
    t.integer "rating"
    t.integer "user_id"
    t.integer "book_id"
    t.boolean "verified", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "accepted", default: false
  end

  create_table "shipping_addresses", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "address"
    t.string "city"
    t.string "zip"
    t.string "country"
    t.string "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "provider"
    t.string "uid"
    t.boolean "is_admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end

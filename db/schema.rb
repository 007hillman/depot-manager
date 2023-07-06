# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_07_06_061514) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accountings", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "auxillary_purchases", force: :cascade do |t|
    t.string "purpose"
    t.decimal "amount_spent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "clients", force: :cascade do |t|
    t.string "name"
    t.string "telephone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "location", default: "Clerk's quarters ,Buea"
  end

  create_table "commands", force: :cascade do |t|
    t.string "client_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "payment_method"
    t.decimal "brasseries_crates_given", default: "0.0"
    t.decimal "guinness_crates_given", default: "0.0"
    t.decimal "amount_paid", default: "0.0"
    t.boolean "paid"
    t.boolean "government"
    t.boolean "delivered"
    t.boolean "transportation"
  end

  create_table "crates", force: :cascade do |t|
    t.bigint "client_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "brasseries_crates"
    t.decimal "guinness_crates"
    t.string "action", default: "delivered"
    t.index ["client_id"], name: "index_crates_on_client_id"
  end

  create_table "debts", force: :cascade do |t|
    t.string "client_name"
    t.decimal "cash_in", precision: 30, scale: 10
    t.decimal "cash_out", precision: 30, scale: 10
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "change"
  end

  create_table "drinks", force: :cascade do |t|
    t.string "name"
    t.string "supplyer"
    t.string "size"
    t.string "packaging"
    t.boolean "alcoholic"
    t.decimal "retail_price"
    t.decimal "wholesale_price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "number_per_package"
    t.string "container_type"
    t.string "abbreviation", default: "ITM"
    t.decimal "buying_cost", default: "0.0"
    t.decimal "safe_quantity", default: "0.0"
    t.decimal "government_price", default: "0.0"
  end

  create_table "goods", force: :cascade do |t|
    t.bigint "purchase_id", null: false
    t.decimal "quantity"
    t.bigint "drink_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["drink_id"], name: "index_goods_on_drink_id"
    t.index ["purchase_id"], name: "index_goods_on_purchase_id"
  end

  create_table "inventories", force: :cascade do |t|
    t.string "action"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "foreign_id"
    t.decimal "quantity"
  end

  create_table "items", force: :cascade do |t|
    t.bigint "drink_id", null: false
    t.bigint "command_id", null: false
    t.decimal "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "bottles"
    t.decimal "discount", default: "0.0"
    t.index ["command_id"], name: "index_items_on_command_id"
    t.index ["drink_id"], name: "index_items_on_drink_id"
  end

  create_table "payments", force: :cascade do |t|
    t.bigint "client_id", null: false
    t.decimal "amount_paid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "command_id", null: false
    t.index ["client_id"], name: "index_payments_on_client_id"
    t.index ["command_id"], name: "index_payments_on_command_id"
  end

  create_table "purchases", force: :cascade do |t|
    t.bigint "supplier_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["supplier_id"], name: "index_purchases_on_supplier_id"
  end

  create_table "reminders", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "suppliers", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.decimal "amount"
    t.string "type", default: "Money"
    t.string "direction", default: "In"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "client_id", null: false
    t.bigint "payment_id", null: false
    t.index ["client_id"], name: "index_transactions_on_client_id"
    t.index ["payment_id"], name: "index_transactions_on_payment_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "crates", "clients"
  add_foreign_key "goods", "drinks"
  add_foreign_key "goods", "purchases"
  add_foreign_key "items", "commands"
  add_foreign_key "items", "drinks"
  add_foreign_key "payments", "clients"
  add_foreign_key "payments", "commands"
  add_foreign_key "purchases", "suppliers"
  add_foreign_key "transactions", "clients"
  add_foreign_key "transactions", "payments"
end

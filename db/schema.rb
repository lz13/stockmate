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

ActiveRecord::Schema[8.1].define(version: 2026_01_17_051443) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "products", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "minimum_quantity", default: 0, null: false
    t.string "name", null: false
    t.integer "price_in_cents", default: 0, null: false
    t.uuid "shop_id", null: false
    t.string "sku"
    t.integer "stock_quantity", default: 0, null: false
    t.datetime "updated_at", null: false
    t.index ["shop_id", "name"], name: "index_products_on_shop_id_and_name", unique: true
    t.index ["shop_id"], name: "index_products_on_shop_id"
  end

  create_table "shops", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "location"
    t.string "name", null: false
    t.uuid "owner_id", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_shops_on_name"
    t.index ["owner_id"], name: "index_shops_on_owner_id"
  end

  create_table "stock_movements", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "change", null: false
    t.datetime "created_at", null: false
    t.integer "movement_type", default: 0, null: false
    t.uuid "product_id", null: false
    t.string "reason", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_stock_movements_on_product_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "products", "shops"
  add_foreign_key "shops", "users", column: "owner_id"
  add_foreign_key "stock_movements", "products"
end

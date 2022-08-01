# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_08_01_012450) do

  create_table "inventories", force: :cascade do |t|
    t.integer "product_id"
    t.integer "store_id"
    t.integer "amount", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_id", "store_id"], name: "index_inventories_on_product_id_and_store_id", unique: true
    t.index ["product_id"], name: "index_inventories_on_product_id"
    t.index ["store_id"], name: "index_inventories_on_store_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name", null: false
    t.string "uid"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["uid"], name: "index_products_on_uid", unique: true
  end

  create_table "stores", force: :cascade do |t|
    t.string "name", null: false
    t.string "uid"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["uid"], name: "index_stores_on_uid", unique: true
  end

end

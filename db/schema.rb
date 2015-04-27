# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150427042833) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.string   "img_url"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "clients", force: :cascade do |t|
    t.string   "name"
    t.boolean  "done",           default: false
    t.boolean  "checking_out",   default: false
    t.string   "payment_method"
    t.integer  "howManyTime"
    t.integer  "table_id"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "clients", ["table_id"], name: "index_clients_on_table_id", using: :btree

  create_table "clients_dishes", force: :cascade do |t|
    t.integer "client_id"
    t.integer "dish_id"
  end

  add_index "clients_dishes", ["client_id"], name: "index_clients_dishes_on_client_id", using: :btree
  add_index "clients_dishes", ["dish_id"], name: "index_clients_dishes_on_dish_id", using: :btree

  create_table "dishes", force: :cascade do |t|
    t.string   "title"
    t.string   "description"
    t.float    "price"
    t.integer  "howManyServe"
    t.string   "photo"
    t.integer  "category_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "pic_file_name"
    t.string   "pic_content_type"
    t.integer  "pic_file_size"
    t.datetime "pic_updated_at"
  end

  add_index "dishes", ["category_id"], name: "index_dishes_on_category_id", using: :btree

  create_table "dishes_orders", force: :cascade do |t|
    t.integer "dish_id"
    t.integer "order_id"
  end

  add_index "dishes_orders", ["dish_id"], name: "index_dishes_orders_on_dish_id", using: :btree
  add_index "dishes_orders", ["order_id"], name: "index_dishes_orders_on_order_id", using: :btree

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "orders", force: :cascade do |t|
    t.float    "total"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tables", force: :cascade do |t|
    t.integer  "number"
    t.string   "code"
    t.integer  "waiter_id"
    t.boolean  "requested"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "waiters", force: :cascade do |t|
    t.string   "name"
    t.string   "last_name"
    t.boolean  "admin",           default: false
    t.string   "password_digest",                 null: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  add_foreign_key "clients", "tables"
  add_foreign_key "dishes", "categories"
end

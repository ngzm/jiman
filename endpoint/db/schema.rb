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

ActiveRecord::Schema.define(version: 2020_05_09_061944) do

  create_table "accounts", force: :cascade do |t|
    t.string "provider", null: false
    t.string "identifier", null: false
    t.string "access_token", null: false
    t.integer "user_id", null: false
    t.datetime "created_at"
    t.index ["user_id"], name: "index_accounts_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "category_jimen", force: :cascade do |t|
    t.integer "category_id", null: false
    t.integer "jiman_id", null: false
    t.datetime "created_at"
    t.index ["category_id"], name: "index_category_jimen_on_category_id"
    t.index ["jiman_id"], name: "index_category_jimen_on_jiman_id"
  end

  create_table "jimen", force: :cascade do |t|
    t.string "title", null: false
    t.string "description", null: false
    t.string "url", null: false
    t.string "image", null: false
    t.integer "access", default: 0, null: false
    t.integer "star", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "reviews", force: :cascade do |t|
    t.text "comment"
    t.integer "star", default: 3, null: false
    t.integer "user_id", null: false
    t.integer "jiman_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["jiman_id"], name: "index_reviews_on_jiman_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "full_name"
    t.string "email"
    t.string "image"
    t.boolean "admin", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "accounts", "users"
  add_foreign_key "category_jimen", "categories"
  add_foreign_key "category_jimen", "jimen"
  add_foreign_key "reviews", "jimen"
  add_foreign_key "reviews", "users"
end

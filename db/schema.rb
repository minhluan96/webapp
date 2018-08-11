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

ActiveRecord::Schema.define(version: 20180811024519) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "case_categories", force: :cascade do |t|
    t.bigint "case_id"
    t.bigint "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "quantity", default: 1
    t.boolean "active"
    t.index ["case_id", "category_id"], name: "case_category_index"
    t.index ["case_id", "category_id"], name: "index_case_category", unique: true
    t.index ["case_id"], name: "index_case_categories_on_case_id"
    t.index ["category_id"], name: "index_case_categories_on_category_id"
  end

  create_table "case_images", force: :cascade do |t|
    t.bigint "case_id"
    t.string "image_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["case_id"], name: "index_case_images_on_case_id"
  end

  create_table "case_videos", force: :cascade do |t|
    t.bigint "case_id"
    t.string "video_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["case_id"], name: "index_case_videos_on_case_id"
  end

  create_table "cases", force: :cascade do |t|
    t.string "name"
    t.string "image"
    t.string "description"
    t.integer "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "category_id"
    t.boolean "is_available", default: true
    t.boolean "is_top_sales", default: false
    t.boolean "is_in_sale", default: false
    t.integer "sale_price"
    t.integer "capital"
    t.index ["category_id"], name: "index_cases_on_category_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_tempered_glass", default: false
  end

  create_table "latest", id: false, force: :cascade do |t|
    t.text "c1"
  end

  create_table "order_details", force: :cascade do |t|
    t.integer "price"
    t.integer "cogs"
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "case_categories_id"
    t.integer "revenue"
    t.index ["case_categories_id"], name: "index_order_details_on_case_categories_id"
  end

  create_table "orders", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.bigint "resource_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource_type_and_resource_id"
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
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "role_id"
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

end

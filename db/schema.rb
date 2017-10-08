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

ActiveRecord::Schema.define(version: 20171007112132) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "branch_managements", force: :cascade do |t|
    t.bigint "branch_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["branch_id"], name: "index_branch_managements_on_branch_id"
    t.index ["user_id"], name: "index_branch_managements_on_user_id"
  end

  create_table "branches", force: :cascade do |t|
    t.bigint "training_center_id"
    t.string "name"
    t.string "avatar"
    t.integer "status"
    t.float "cached_avarage_rating"
    t.text "description"
    t.bigint "city_id"
    t.bigint "district_id"
    t.string "address"
    t.point "coordinates"
    t.string "phone_number"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city_id"], name: "index_branches_on_city_id"
    t.index ["district_id"], name: "index_branches_on_district_id"
    t.index ["training_center_id"], name: "index_branches_on_training_center_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.bigint "training_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["training_type_id"], name: "index_categories_on_training_type_id"
  end

  create_table "cities", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.string "type"
    t.bigint "user_id"
    t.bigint "review_id"
    t.bigint "branch_id"
    t.text "content"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["branch_id"], name: "index_comments_on_branch_id"
    t.index ["review_id"], name: "index_comments_on_review_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "districts", force: :cascade do |t|
    t.string "name"
    t.bigint "city_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city_id"], name: "index_districts_on_city_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "branch_id"
    t.string "title"
    t.text "content"
    t.float "average_rating"
    t.integer "rating_criteria_1"
    t.integer "rating_criteria_2"
    t.integer "rating_criteria_3"
    t.integer "rating_criteria_4"
    t.integer "rating_criteria_5"
    t.integer "status"
    t.string "email_verify"
    t.string "phone_number_verify"
    t.integer "verifier_id"
    t.datetime "verified_at"
    t.string "note"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["branch_id"], name: "index_reviews_on_branch_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "training_center_categories", force: :cascade do |t|
    t.bigint "category_id"
    t.bigint "training_center_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_training_center_categories_on_category_id"
    t.index ["training_center_id"], name: "index_training_center_categories_on_training_center_id"
  end

  create_table "training_center_managements", force: :cascade do |t|
    t.bigint "training_center_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["training_center_id"], name: "index_training_center_managements_on_training_center_id"
    t.index ["user_id"], name: "index_training_center_managements_on_user_id"
  end

  create_table "training_center_requests", force: :cascade do |t|
    t.bigint "user_id"
    t.string "training_center_name"
    t.string "reference_website"
    t.string "reference_fanpage"
    t.string "phone_number"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_training_center_requests_on_user_id"
  end

  create_table "training_centers", force: :cascade do |t|
    t.bigint "training_type_id"
    t.string "name"
    t.integer "status"
    t.string "avatar"
    t.text "description"
    t.float "cached_average_rating"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["training_type_id"], name: "index_training_centers_on_training_type_id"
  end

  create_table "training_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "first_name"
    t.string "last_name"
    t.string "username"
    t.string "avatar"
    t.string "phone_number"
    t.integer "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "votes", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "review_id"
    t.integer "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["review_id"], name: "index_votes_on_review_id"
    t.index ["user_id"], name: "index_votes_on_user_id"
  end

  add_foreign_key "branch_managements", "branches"
  add_foreign_key "branch_managements", "users"
  add_foreign_key "branches", "cities"
  add_foreign_key "branches", "districts"
  add_foreign_key "branches", "training_centers"
  add_foreign_key "categories", "training_types"
  add_foreign_key "comments", "branches"
  add_foreign_key "comments", "reviews"
  add_foreign_key "comments", "users"
  add_foreign_key "districts", "cities"
  add_foreign_key "reviews", "branches"
  add_foreign_key "reviews", "users"
  add_foreign_key "training_center_categories", "categories"
  add_foreign_key "training_center_categories", "training_centers"
  add_foreign_key "training_center_managements", "training_centers"
  add_foreign_key "training_center_managements", "users"
  add_foreign_key "training_center_requests", "users"
  add_foreign_key "training_centers", "training_types"
  add_foreign_key "votes", "users"
end

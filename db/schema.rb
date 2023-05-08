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

ActiveRecord::Schema.define(version: 2023_05_08_191344) do

  create_table "add_likes_count_to_users", force: :cascade do |t|
  end

  create_table "add_private_to_users", force: :cascade do |t|
  end

  create_table "comments", force: :cascade do |t|
  end

  create_table "follow_requests", force: :cascade do |t|
  end

  create_table "likes", force: :cascade do |t|
  end

  create_table "photos", force: :cascade do |t|
    t.string "caption"
    t.string "image"
    t.integer "owner_id"
    t.string "location"
    t.integer "likes_count"
    t.integer "comments_count"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.string "username"
    t.integer "sent_follow_requests_count"
    t.integer "received_follow_requests_count"
    t.integer "own_photos_count"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end

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

ActiveRecord::Schema.define(version: 20180410012802) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "friendships", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "friend_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["friend_id"], name: "index_friendships_on_friend_id"
    t.index ["user_id"], name: "index_friendships_on_user_id"
  end

  create_table "inventories", force: :cascade do |t|
    t.integer "quantity"
    t.bigint "user_id"
    t.bigint "item_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_inventories_on_item_id"
    t.index ["user_id"], name: "index_inventories_on_user_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "name", null: false
    t.integer "price", null: false
    t.string "picture", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "matches", force: :cascade do |t|
    t.integer "score", default: 0, null: false
    t.integer "destroyed_ships", default: 0, null: false
    t.integer "lost_ships", default: 0, null: false
    t.boolean "turn", default: false
    t.boolean "finished", default: false
    t.boolean "victory"
    t.boolean "board_set", default: false
    t.json "board"
    t.integer "game_number", null: false
    t.bigint "user_id", null: false
    t.bigint "rival_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["rival_id"], name: "index_matches_on_rival_id"
    t.index ["user_id"], name: "index_matches_on_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.string "text"
    t.bigint "friendship_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["friendship_id"], name: "index_messages_on_friendship_id"
  end

  create_table "user_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.string "picture", default: "https://res.cloudinary.com/epikhdez/image/upload/v1523240311/no_image.png"
    t.integer "money", default: 500
    t.bigint "user_type_id", default: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email"
    t.index ["user_type_id"], name: "index_users_on_user_type_id"
  end

  add_foreign_key "friendships", "users"
  add_foreign_key "friendships", "users", column: "friend_id"
  add_foreign_key "inventories", "items"
  add_foreign_key "inventories", "users"
  add_foreign_key "matches", "users"
  add_foreign_key "matches", "users", column: "rival_id"
  add_foreign_key "messages", "friendships"
end

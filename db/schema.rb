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

ActiveRecord::Schema.define(version: 2021_03_28_173021) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "games", force: :cascade do |t|
    t.string "name", null: false
    t.integer "players_count"
    t.integer "rounds_count"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_games_on_name", unique: true
  end

  create_table "hands", force: :cascade do |t|
    t.integer "number", null: false
    t.string "card_list", null: false
    t.bigint "player_id", null: false
    t.bigint "round_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["player_id"], name: "index_hands_on_player_id"
    t.index ["round_id"], name: "index_hands_on_round_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "game_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["game_id"], name: "index_players_on_game_id"
    t.index ["name"], name: "index_players_on_name", unique: true
  end

  create_table "rounds", force: :cascade do |t|
    t.integer "number", null: false
    t.bigint "game_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["game_id"], name: "index_rounds_on_game_id"
    t.index ["number", "game_id"], name: "index_rounds_on_number_and_game_id", unique: true
  end

  create_table "wins", force: :cascade do |t|
    t.boolean "status", default: false
    t.string "rank", null: false
    t.bigint "round_id", null: false
    t.bigint "hand_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["hand_id"], name: "index_wins_on_hand_id"
    t.index ["round_id"], name: "index_wins_on_round_id"
  end

  add_foreign_key "hands", "players"
  add_foreign_key "hands", "rounds"
  add_foreign_key "players", "games"
  add_foreign_key "rounds", "games"
  add_foreign_key "wins", "hands"
  add_foreign_key "wins", "rounds"
end

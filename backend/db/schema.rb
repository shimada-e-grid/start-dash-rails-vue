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

ActiveRecord::Schema.define(version: 2021_08_17_093805) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "leagues", force: :cascade do |t|
    t.string "name", limit: 100, null: false
    t.integer "country_number", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_leagues_on_name", unique: true
  end

  create_table "player_positions", force: :cascade do |t|
    t.bigint "player_id", null: false
    t.bigint "position_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["player_id", "position_id"], name: "index_player_positions_on_player_id_and_position_id", unique: true
    t.index ["player_id"], name: "index_player_positions_on_player_id"
    t.index ["position_id"], name: "index_player_positions_on_position_id"
  end

  create_table "players", force: :cascade do |t|
    t.bigint "team_id", null: false
    t.string "name", limit: 100, null: false
    t.date "birthday", null: false
    t.integer "uniform_number", null: false
    t.integer "country_number", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["team_id", "uniform_number"], name: "index_players_on_team_id_and_uniform_number", unique: true
  end

  create_table "position_roles", force: :cascade do |t|
    t.bigint "position_id", null: false
    t.string "name", limit: 50, null: false
    t.string "short_name", limit: 10, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_position_roles_on_name", unique: true
    t.index ["position_id"], name: "index_position_roles_on_position_id"
    t.index ["short_name"], name: "index_position_roles_on_short_name", unique: true
  end

  create_table "positions", force: :cascade do |t|
    t.string "name", limit: 50, null: false
    t.string "short_name", limit: 10, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_positions_on_name", unique: true
    t.index ["short_name"], name: "index_positions_on_short_name", unique: true
  end

  create_table "teams", force: :cascade do |t|
    t.bigint "league_id", null: false
    t.string "name", limit: 100, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["league_id", "name"], name: "index_teams_on_league_id_and_name", unique: true
  end

  add_foreign_key "player_positions", "players"
  add_foreign_key "player_positions", "positions"
  add_foreign_key "players", "teams"
  add_foreign_key "position_roles", "positions"
  add_foreign_key "teams", "leagues"
end

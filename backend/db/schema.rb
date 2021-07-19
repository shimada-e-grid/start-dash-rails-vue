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

ActiveRecord::Schema.define(version: 2021_07_09_051635) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "leagues", force: :cascade do |t|
    t.string "name", limit: 100, null: false
    t.integer "country_number", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_leagues_on_name", unique: true
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

  create_table "teams", force: :cascade do |t|
    t.bigint "league_id", null: false
    t.string "name", limit: 100, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["league_id", "name"], name: "index_teams_on_league_id_and_name", unique: true
  end

  add_foreign_key "players", "teams"
  add_foreign_key "teams", "leagues"
end

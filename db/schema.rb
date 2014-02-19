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

ActiveRecord::Schema.define(version: 20140218144001) do

  create_table "connections", force: true do |t|
    t.integer  "node_id1"
    t.integer  "node_id2"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "games", force: true do |t|
    t.string   "name"
    t.string   "password"
    t.datetime "start_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "nodes", force: true do |t|
    t.integer  "place_id"
    t.integer  "game_id"
    t.integer  "player_id"
    t.datetime "claimed_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "places", force: true do |t|
    t.string "name"
    t.float  "x"
    t.float  "y"
    t.string "category"
  end

  create_table "players", force: true do |t|
    t.string   "name"
    t.string   "password"
    t.integer  "game_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end

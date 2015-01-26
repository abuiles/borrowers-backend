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

ActiveRecord::Schema.define(version: 20150126155513) do

  create_table "articles", force: true do |t|
    t.string   "description"
    t.string   "state",       default: "borrowed"
    t.string   "friend_id",                        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "notes",       default: ""
  end

  create_table "clients", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "twitter"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "friends", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "twitter"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "total_articles", default: 0, null: false
  end

end

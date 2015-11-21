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

ActiveRecord::Schema.define(version: 20151111190255) do

  create_table "alleys", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.boolean  "active"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "alleys_meetings", id: false, force: :cascade do |t|
    t.integer "alley_id",   limit: 4, null: false
    t.integer "meeting_id", limit: 4, null: false
  end

  create_table "meetings", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "email",      limit: 255
    t.string   "phone",      limit: 255
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.boolean  "accepted",                 default: false
    t.text     "note",       limit: 65535
  end

end

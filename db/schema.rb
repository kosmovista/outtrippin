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

ActiveRecord::Schema.define(version: 20131118104340) do

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority"

  create_table "itineraries", force: true do |t|
    t.string   "departure"
    t.integer  "user_id"
    t.string   "destination"
    t.string   "duration"
    t.integer  "description"
    t.boolean  "paid"
    t.text     "extra_info"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pictures", force: true do |t|
    t.string   "source"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pitches", force: true do |t|
    t.string   "title"
    t.text     "summary"
    t.text     "why_me"
    t.integer  "user_id"
    t.integer  "itinerary_id"
    t.boolean  "published"
    t.boolean  "winner"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",             null: false
    t.text     "personal_info"
    t.text     "expert_info"
    t.string   "avatar"
    t.integer  "roles_mask"
    t.string   "crypted_password",  null: false
    t.string   "password_salt",     null: false
    t.string   "persistence_token", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end

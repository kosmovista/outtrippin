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

ActiveRecord::Schema.define(version: 20140121172624) do

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
    t.boolean  "published",   default: false
  end

  create_table "pictures", force: true do |t|
    t.integer  "user_id"
    t.string   "source"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "cover",      default: false
  end

  create_table "pictures_pitches", force: true do |t|
    t.integer "picture_id"
    t.integer "pitch_id"
  end

  create_table "pictures_plans", force: true do |t|
    t.integer "picture_id"
    t.integer "plan_id"
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

  create_table "plans", force: true do |t|
    t.string   "title"
    t.text     "days"
    t.text     "tips_tricks"
    t.boolean  "published",    default: false
    t.integer  "user_id"
    t.integer  "itinerary_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "draft",        default: true
  end

  create_table "users", force: true do |t|
    t.string   "email",                          null: false
    t.text     "personal_info"
    t.text     "expert_info"
    t.string   "avatar"
    t.integer  "roles_mask"
    t.string   "crypted_password",               null: false
    t.string   "password_salt",                  null: false
    t.string   "persistence_token",              null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "perishable_token",  default: ""
  end

  add_index "users", ["perishable_token"], name: "index_users_on_perishable_token"

  create_table "votes", force: true do |t|
    t.integer  "votable_id"
    t.string   "votable_type"
    t.integer  "voter_id"
    t.string   "voter_type"
    t.boolean  "vote_flag"
    t.string   "vote_scope"
    t.integer  "vote_weight"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope"
  add_index "votes", ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope"

end

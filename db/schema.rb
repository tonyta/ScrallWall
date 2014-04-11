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

ActiveRecord::Schema.define(version: 20140411163944) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "artifact_tags", force: true do |t|
    t.integer  "user_id"
    t.integer  "artifact_id"
    t.integer  "tag_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "artifacts", force: true do |t|
    t.integer  "neighborhood_id"
    t.string   "geotag"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "location_id"
    t.float    "latitude"
    t.float    "longitude"
  end

  create_table "favs", force: true do |t|
    t.integer  "user_id"
    t.integer  "artifact_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "flags", force: true do |t|
    t.integer  "user_id"
    t.integer  "flaggable_id"
    t.string   "flaggable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "locations", force: true do |t|
    t.string   "address"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "neighborhoods", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pictures", force: true do |t|
    t.integer  "user_id"
    t.integer  "artifact_id"
    t.string   "url"
    t.string   "thumb_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "picture"
  end

  create_table "reflections", force: true do |t|
    t.integer  "user_id"
    t.integer  "artifact_id"
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tags", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.text     "bio"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "votes", force: true do |t|
    t.integer  "user_id"
    t.integer  "votable_id"
    t.string   "votable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end

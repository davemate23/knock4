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

ActiveRecord::Schema.define(version: 20140301150358) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "knockers", force: true do |t|
    t.string   "first_name",                          null: false
    t.string   "last_name",                           null: false
    t.string   "username",                            null: false
    t.string   "town"
    t.string   "postcode"
    t.float    "latitude"
    t.float    "longitude"
    t.date     "birthday",                            null: false
    t.text     "about"
    t.string   "gender",                              null: false
    t.string   "nationality"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "provider"
    t.string   "uid"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  add_index "knockers", ["birthday"], name: "index_knockers_on_birthday", using: :btree
  add_index "knockers", ["email"], name: "index_knockers_on_email", unique: true, using: :btree
  add_index "knockers", ["latitude"], name: "index_knockers_on_latitude", using: :btree
  add_index "knockers", ["longitude"], name: "index_knockers_on_longitude", using: :btree
  add_index "knockers", ["reset_password_token"], name: "index_knockers_on_reset_password_token", unique: true, using: :btree
  add_index "knockers", ["username"], name: "index_knockers_on_username", unique: true, using: :btree

end

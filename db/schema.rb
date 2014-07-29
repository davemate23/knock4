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

ActiveRecord::Schema.define(version: 20140624200534) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "availabilities", force: true do |t|
    t.integer  "knocker_id"
    t.date     "availability"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "availabilities", ["availability"], name: "index_availabilities_on_availability", using: :btree
  add_index "availabilities", ["knocker_id"], name: "index_availabilities_on_knocker_id", using: :btree

  create_table "event_attendances", force: true do |t|
    t.integer  "knocker_id"
    t.integer  "event_id"
    t.integer  "admin",      default: 0
    t.integer  "state"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "event_attendances", ["event_id"], name: "index_event_attendances_on_event_id", using: :btree
  add_index "event_attendances", ["knocker_id", "event_id"], name: "index_event_attendances_on_knocker_id_and_event_id", using: :btree
  add_index "event_attendances", ["knocker_id"], name: "index_event_attendances_on_knocker_id", using: :btree

  create_table "event_interests", force: true do |t|
    t.integer  "event_id"
    t.integer  "interest_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "event_interests", ["event_id"], name: "index_event_interests_on_event_id", using: :btree
  add_index "event_interests", ["interest_id", "event_id"], name: "index_event_interests_on_interest_id_and_event_id", using: :btree
  add_index "event_interests", ["interest_id"], name: "index_event_interests_on_interest_id", using: :btree

  create_table "event_venues", force: true do |t|
    t.integer  "event_id"
    t.integer  "venue_id"
    t.integer  "status"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "event_venues", ["event_id", "venue_id"], name: "index_event_venues_on_event_id_and_venue_id", using: :btree
  add_index "event_venues", ["event_id"], name: "index_event_venues_on_event_id", using: :btree
  add_index "event_venues", ["venue_id"], name: "index_event_venues_on_venue_id", using: :btree

  create_table "events", force: true do |t|
    t.string   "identity"
    t.string   "name"
    t.datetime "start_time"
    t.datetime "end_time"
    t.text     "description"
    t.string   "website"
    t.boolean  "private"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  add_index "events", ["end_time"], name: "index_events_on_end_time", using: :btree
  add_index "events", ["name"], name: "index_events_on_name", using: :btree
  add_index "events", ["start_time"], name: "index_events_on_start_time", using: :btree

  create_table "favouriteknockers", force: true do |t|
    t.integer  "favourited_id"
    t.integer  "favourite_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "favouriteknockers", ["favourite_id"], name: "index_favouriteknockers_on_favourite_id", using: :btree
  add_index "favouriteknockers", ["favourited_id", "favourite_id"], name: "index_favouriteknockers_on_favourited_id_and_favourite_id", unique: true, using: :btree
  add_index "favouriteknockers", ["favourited_id"], name: "index_favouriteknockers_on_favourited_id", using: :btree

  create_table "group_events", force: true do |t|
    t.integer  "group_id"
    t.integer  "event_id"
    t.integer  "status",      default: 0
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "group_events", ["event_id"], name: "index_group_events_on_event_id", using: :btree
  add_index "group_events", ["group_id", "event_id"], name: "index_group_events_on_group_id_and_event_id", using: :btree
  add_index "group_events", ["group_id"], name: "index_group_events_on_group_id", using: :btree

  create_table "group_members", force: true do |t|
    t.integer  "knocker_id"
    t.integer  "group_id"
    t.integer  "admin",      default: 0
    t.integer  "state",      default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "group_members", ["group_id"], name: "index_group_members_on_group_id", using: :btree
  add_index "group_members", ["knocker_id", "group_id"], name: "index_group_members_on_knocker_id_and_group_id", using: :btree
  add_index "group_members", ["knocker_id"], name: "index_group_members_on_knocker_id", using: :btree

  create_table "group_venues", force: true do |t|
    t.integer  "group_id"
    t.integer  "venue_id"
    t.integer  "status",     default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "group_venues", ["group_id", "venue_id"], name: "index_group_venues_on_group_id_and_venue_id", using: :btree
  add_index "group_venues", ["group_id"], name: "index_group_venues_on_group_id", using: :btree
  add_index "group_venues", ["venue_id"], name: "index_group_venues_on_venue_id", using: :btree

  create_table "groups", force: true do |t|
    t.string   "name"
    t.string   "identity"
    t.text     "description"
    t.string   "website"
    t.string   "phone"
    t.boolean  "private"
    t.boolean  "invite"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  add_index "groups", ["name"], name: "index_groups_on_name", using: :btree

  create_table "groups_interests", force: true do |t|
    t.integer  "group_id"
    t.integer  "interest_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "groups_interests", ["group_id", "interest_id"], name: "index_groups_interests_on_group_id_and_interest_id", using: :btree
  add_index "groups_interests", ["group_id"], name: "index_groups_interests_on_group_id", using: :btree
  add_index "groups_interests", ["interest_id"], name: "index_groups_interests_on_interest_id", using: :btree

  create_table "hypes", force: true do |t|
    t.string   "content"
    t.integer  "author_id"
    t.string   "author_type"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "hypes", ["author_id", "author_type", "created_at"], name: "index_hypes_on_author_id_and_author_type_and_created_at", using: :btree
  add_index "hypes", ["latitude", "longitude"], name: "index_hypes_on_latitude_and_longitude", using: :btree

  create_table "interests", force: true do |t|
    t.string   "title"
    t.string   "wikipedia"
    t.text     "summary"
    t.text     "content"
    t.string   "image_url"
    t.string   "verb"
    t.string   "thirdperson"
    t.string   "parent"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  add_index "interests", ["title"], name: "index_interests_on_title", using: :btree

  create_table "knocker_interests", force: true do |t|
    t.integer  "knocker_id"
    t.integer  "interest_id"
    t.integer  "ability"
    t.boolean  "thirdparty"
    t.boolean  "teach"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "knocker_interests", ["ability"], name: "index_knocker_interests_on_ability", using: :btree
  add_index "knocker_interests", ["interest_id"], name: "index_knocker_interests_on_interest_id", using: :btree
  add_index "knocker_interests", ["knocker_id", "interest_id"], name: "index_knocker_interests_on_knocker_id_and_interest_id", unique: true, using: :btree
  add_index "knocker_interests", ["knocker_id"], name: "index_knocker_interests_on_knocker_id", using: :btree
  add_index "knocker_interests", ["teach"], name: "index_knocker_interests_on_teach", using: :btree
  add_index "knocker_interests", ["thirdparty"], name: "index_knocker_interests_on_thirdparty", using: :btree

  create_table "knocker_venues", force: true do |t|
    t.integer  "knocker_id"
    t.integer  "venue_id"
    t.integer  "admin",      default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "knocker_venues", ["knocker_id", "venue_id"], name: "index_knocker_venues_on_knocker_id_and_venue_id", unique: true, using: :btree
  add_index "knocker_venues", ["knocker_id"], name: "index_knocker_venues_on_knocker_id", using: :btree
  add_index "knocker_venues", ["venue_id"], name: "index_knocker_venues_on_venue_id", using: :btree

  create_table "knockers", force: true do |t|
    t.string   "first_name",                             null: false
    t.string   "last_name",                              null: false
    t.string   "identity",                               null: false
    t.string   "town"
    t.string   "postcode"
    t.string   "country"
    t.float    "latitude"
    t.float    "longitude"
    t.date     "birthday",                               null: false
    t.string   "gender",                                 null: false
    t.boolean  "admin",                  default: false
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "provider"
    t.string   "uid"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "failed_attempts",        default: 0,     null: false
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
  add_index "knockers", ["identity"], name: "index_knockers_on_identity", unique: true, using: :btree
  add_index "knockers", ["latitude", "longitude"], name: "index_knockers_on_latitude_and_longitude", using: :btree
  add_index "knockers", ["reset_password_token"], name: "index_knockers_on_reset_password_token", unique: true, using: :btree

  create_table "mailboxer_conversations", force: true do |t|
    t.string   "subject",    default: ""
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "mailboxer_notifications", force: true do |t|
    t.string   "type"
    t.text     "body"
    t.string   "subject",              default: ""
    t.integer  "sender_id"
    t.string   "sender_type"
    t.integer  "conversation_id"
    t.boolean  "draft",                default: false
    t.datetime "updated_at",                           null: false
    t.datetime "created_at",                           null: false
    t.integer  "notified_object_id"
    t.string   "notified_object_type"
    t.string   "notification_code"
    t.string   "attachment"
    t.boolean  "global",               default: false
    t.datetime "expires"
  end

  add_index "mailboxer_notifications", ["conversation_id"], name: "index_mailboxer_notifications_on_conversation_id", using: :btree

  create_table "mailboxer_receipts", force: true do |t|
    t.integer  "receiver_id"
    t.string   "receiver_type"
    t.integer  "notification_id",                            null: false
    t.boolean  "is_read",                    default: false
    t.boolean  "trashed",                    default: false
    t.boolean  "deleted",                    default: false
    t.string   "mailbox_type",    limit: 25
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  add_index "mailboxer_receipts", ["notification_id"], name: "index_mailboxer_receipts_on_notification_id", using: :btree

  create_table "posts", force: true do |t|
    t.integer  "knocker_id"
    t.string   "content"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "postable_id"
    t.string   "postable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "posts", ["knocker_id"], name: "index_posts_on_knocker_id", using: :btree
  add_index "posts", ["latitude", "longitude"], name: "index_posts_on_latitude_and_longitude", using: :btree
  add_index "posts", ["postable_id", "created_at"], name: "index_posts_on_postable_id_and_created_at", using: :btree
  add_index "posts", ["postable_id", "postable_type"], name: "index_posts_on_postable_id_and_postable_type", using: :btree

  create_table "profiles", force: true do |t|
    t.integer  "knocker_id"
    t.text     "about"
    t.string   "nationality"
    t.string   "occupation"
    t.string   "employer"
    t.boolean  "transport"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "profiles", ["employer"], name: "index_profiles_on_employer", using: :btree
  add_index "profiles", ["knocker_id"], name: "index_profiles_on_knocker_id", using: :btree
  add_index "profiles", ["nationality"], name: "index_profiles_on_nationality", using: :btree
  add_index "profiles", ["occupation"], name: "index_profiles_on_occupation", using: :btree

  create_table "venue_interests", force: true do |t|
    t.integer  "venue_id"
    t.integer  "interest_id"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "venue_interests", ["interest_id"], name: "index_venue_interests_on_interest_id", using: :btree
  add_index "venue_interests", ["venue_id", "interest_id"], name: "index_venue_interests_on_venue_id_and_interest_id", unique: true, using: :btree
  add_index "venue_interests", ["venue_id"], name: "index_venue_interests_on_venue_id", using: :btree

  create_table "venues", force: true do |t|
    t.string   "name"
    t.string   "identity"
    t.string   "address1"
    t.string   "address2"
    t.string   "town"
    t.string   "county"
    t.string   "postcode"
    t.string   "country"
    t.string   "website"
    t.string   "phone"
    t.text     "description"
    t.float    "latitude"
    t.float    "longitude"
    t.boolean  "disabled"
    t.boolean  "parking"
    t.boolean  "toilets"
    t.boolean  "food"
    t.boolean  "drink"
    t.boolean  "alcohol"
    t.boolean  "changing"
    t.boolean  "baby_changing"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  add_index "venues", ["identity"], name: "index_venues_on_identity", using: :btree
  add_index "venues", ["latitude", "longitude"], name: "index_venues_on_latitude_and_longitude", using: :btree
  add_index "venues", ["name"], name: "index_venues_on_name", using: :btree

  add_foreign_key "mailboxer_notifications", "mailboxer_conversations", name: "notifications_on_conversation_id", column: "conversation_id"

  add_foreign_key "mailboxer_receipts", "mailboxer_notifications", name: "receipts_on_notification_id", column: "notification_id"

end

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

ActiveRecord::Schema.define(version: 20150702123119) do

  create_table "documents", force: :cascade do |t|
    t.string   "location",    limit: 255
    t.string   "title",       limit: 255
    t.text     "description", limit: 16777215
    t.integer  "user_id",     limit: 4
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "category",    limit: 4
  end

  add_index "documents", ["user_id"], name: "index_documents_on_user_id", using: :btree

  create_table "elements_assocs", force: :cascade do |t|
    t.integer  "element1_id",   limit: 4
    t.string   "element1_type", limit: 255
    t.integer  "element2_id",   limit: 4
    t.string   "element2_type", limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "elements_assocs", ["element1_type", "element1_id"], name: "index_elements_assocs_on_element1_type_and_element1_id", using: :btree
  add_index "elements_assocs", ["element2_type", "element2_id"], name: "index_elements_assocs_on_element2_type_and_element2_id", using: :btree

  create_table "ideas", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.text     "description", limit: 16777215
    t.string   "files",       limit: 255
    t.integer  "user_id",     limit: 4
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "ideas", ["user_id"], name: "index_ideas_on_user_id", using: :btree

  create_table "langs", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "langs_people", id: false, force: :cascade do |t|
    t.integer "person_id", limit: 4, null: false
    t.integer "lang_id",   limit: 4, null: false
  end

  create_table "people", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.string   "url",             limit: 255
    t.string   "contact_name",    limit: 255
    t.string   "files",           limit: 255
    t.integer  "category",        limit: 4
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "user_id",         limit: 4
    t.text     "characteristics", limit: 16777215
    t.string   "firstname",       limit: 255
    t.string   "profile",         limit: 255
    t.integer  "company_type",    limit: 4
  end

  add_index "people", ["user_id"], name: "index_people_on_user_id", using: :btree

  create_table "places", force: :cascade do |t|
    t.string   "gmaps_address", limit: 255
    t.string   "gmaps_id",      limit: 255
    t.boolean  "is_hq",         limit: 1
    t.integer  "person_id",     limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "places", ["person_id"], name: "index_places_on_person_id", using: :btree

  create_table "tag_assocs", force: :cascade do |t|
    t.integer  "tag_id",       limit: 4
    t.integer  "element_id",   limit: 4
    t.string   "element_type", limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "tag_assocs", ["element_type", "element_id"], name: "index_tag_assocs_on_element_type_and_element_id", using: :btree
  add_index "tag_assocs", ["tag_id"], name: "index_tag_assocs_on_tag_id", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string   "tag",        limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "technologies", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.string   "url",             limit: 255
    t.text     "description",     limit: 16777215
    t.string   "files",           limit: 255
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "user_id",         limit: 4
    t.string   "editor",          limit: 255
    t.integer  "license",         limit: 4
    t.integer  "pricing",         limit: 4
    t.text     "characteristics", limit: 16777215
  end

  add_index "technologies", ["user_id"], name: "index_technologies_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "lastname",               limit: 255
    t.string   "firstname",              limit: 255
    t.string   "picture",                limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "documents", "users"
  add_foreign_key "ideas", "users"
  add_foreign_key "people", "users"
  add_foreign_key "places", "people"
  add_foreign_key "tag_assocs", "tags"
  add_foreign_key "technologies", "users"
end

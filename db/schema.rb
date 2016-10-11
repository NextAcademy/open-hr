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

ActiveRecord::Schema.define(version: 20161006053800) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "available_remaining_leaves", force: :cascade do |t|
    t.integer  "contract_id"
    t.integer  "leave_type_id"
    t.float    "number_of_days", default: 0.0
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "contracts", force: :cascade do |t|
    t.integer  "staff_id"
    t.integer  "department_id"
    t.string   "job_title"
    t.float    "salary"
    t.datetime "commencement_date"
    t.datetime "end_date"
    t.integer  "status",             default: 0
    t.json     "contract_documents"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "departments", force: :cascade do |t|
    t.string   "name"
    t.string   "head_of_department"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "invites", force: :cascade do |t|
    t.string   "email"
    t.string   "invite_code", limit: 40
    t.datetime "invited_at"
    t.datetime "redeemed_at"
  end

  add_index "invites", ["id", "email"], name: "index_invites_on_id_and_email", using: :btree
  add_index "invites", ["id", "invite_code"], name: "index_invites_on_id_and_invite_code", using: :btree

  create_table "leave_applications", force: :cascade do |t|
    t.integer  "staff_id"
    t.integer  "leave_type_id"
    t.text     "description"
    t.integer  "status",        default: 0
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "leave_types", force: :cascade do |t|
    t.string   "leave_type_name"
    t.boolean  "unpaid_leave",    default: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  create_table "staffs", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "full_name"
    t.string   "identification_number"
    t.string   "contact_number"
    t.string   "address"
    t.datetime "date_of_birth"
    t.json     "identification_documents"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.string   "email",                                      null: false
    t.string   "encrypted_password", limit: 128,             null: false
    t.string   "confirmation_token", limit: 128
    t.string   "remember_token",     limit: 128,             null: false
    t.integer  "category",                       default: 3
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree

  create_table "workdays", force: :cascade do |t|
    t.date     "workdate"
    t.float    "full_or_half"
    t.boolean  "holiday"
    t.string   "holiday_name"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

end

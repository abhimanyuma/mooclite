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

ActiveRecord::Schema.define(version: 20141006122631) do

  create_table "courses", force: true do |t|
    t.string   "name"
    t.string   "slug"
    t.text     "description"
    t.string   "offered_by"
    t.string   "bio"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lectures", force: true do |t|
    t.string   "title"
    t.integer  "instructor_id"
    t.text     "content"
    t.date     "date"
    t.string   "overview"
    t.integer  "course_id"
    t.integer  "lecture_no"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "video_file_name"
    t.string   "video_content_type"
    t.integer  "video_file_size"
    t.datetime "video_updated_at"
    t.string   "slide_file_name"
    t.string   "slide_content_type"
    t.integer  "slide_file_size"
    t.datetime "slide_updated_at"
    t.string   "video_fingerprint"
    t.string   "slide_fingerprint"
    t.string   "processed_video_fingerprint"
    t.integer  "process_status",              default: 0
  end

  add_index "lectures", ["course_id", "lecture_no"], name: "index_lectures_on_course_id_and_lecture_no"
  add_index "lectures", ["course_id"], name: "index_lectures_on_course_id"
  add_index "lectures", ["date"], name: "index_lectures_on_date"

  create_table "users", force: true do |t|
    t.string   "name",                                null: false
    t.string   "email",                               null: false
    t.string   "password_digest",                     null: false
    t.string   "institute"
    t.string   "role"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "users", ["email"], name: "index_users_on_email"
  add_index "users", ["name"], name: "index_users_on_name"
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end

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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120423042510) do

  create_table "assignments", :force => true do |t|
    t.string   "name"
    t.string   "assignment_type"
    t.datetime "start_date",        :limit => 255
    t.datetime "due_date",          :limit => 255
    t.integer  "priority"
    t.text     "notes"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.integer  "course_id"
    t.string   "notification_type"
  end

  create_table "attachments", :force => true do |t|
    t.string   "name"
    t.string   "type"
    t.string   "upload_date"
    t.string   "server_path"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "course_id"
    t.integer  "assignment_id"
  end

  create_table "courses", :force => true do |t|
    t.string   "name"
    t.string   "course_number"
    t.string   "school"
    t.string   "section"
    t.string   "code"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.integer  "user_id"
    t.string   "color"
    t.boolean  "published",     :default => false
  end

  create_table "courses_teachers", :id => false, :force => true do |t|
    t.integer "teacher_id"
    t.integer "course_id"
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "teachers", :force => true do |t|
    t.string   "last"
    t.string   "email"
    t.string   "office_hours"
    t.string   "phone"
    t.string   "instructor_type"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.integer  "title"
    t.string   "first"
    t.datetime "photo_updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
  end

  create_table "universities", :force => true do |t|
    t.string   "name"
    t.string   "city"
    t.string   "state"
    t.string   "website"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "password"
    t.string   "pass_salt"
    t.string   "persistence_token"
    t.string   "first"
    t.string   "last"
    t.string   "email"
    t.string   "phone"
    t.integer  "user_type"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

end

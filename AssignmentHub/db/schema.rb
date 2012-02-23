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

ActiveRecord::Schema.define(:version => 20120223014311) do

  create_table "assignments", :force => true do |t|
    t.string   "name"
    t.string   "type"
    t.string   "start_date"
    t.string   "due_date"
    t.integer  "priority"
    t.string   "notes"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "attachments", :force => true do |t|
    t.string   "name"
    t.string   "type"
    t.string   "upload_date"
    t.string   "server_path"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "courses", :force => true do |t|
    t.string   "name"
    t.string   "course_number"
    t.string   "school"
    t.string   "section"
    t.string   "code"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "teachers", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "office_hours"
    t.string   "phone"
    t.string   "type"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "password"
    t.string   "first"
    t.string   "last"
    t.string   "email"
    t.string   "phone"
    t.integer  "user_type"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end

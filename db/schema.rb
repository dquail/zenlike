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

ActiveRecord::Schema.define(:version => 20130227055318) do

  create_table "calendar_guesses", :force => true do |t|
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.integer  "meeting_thread_id"
    t.integer  "turker_id"
    t.string   "location"
    t.string   "participants"
    t.text     "description"
    t.datetime "start_date_time"
    t.datetime "end_date_time"
    t.string   "time_zone"
  end

  create_table "meeting_requests", :force => true do |t|
    t.integer  "meeting_thread_id"
    t.string   "location"
    t.string   "participants"
    t.string   "description"
    t.string   "datetime"
    t.string   "time_zone"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.datetime "start_date_time"
    t.datetime "end_date_time"
  end

  create_table "meeting_threads", :force => true do |t|
    t.integer  "user_id"
    t.text     "headers"
    t.text     "text"
    t.text     "html"
    t.string   "from"
    t.string   "to"
    t.string   "cc"
    t.string   "subject"
    t.integer  "attachmen_count"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.string   "status",          :default => "open"
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.string   "confirmation_code"
    t.boolean  "confirmed",         :default => false
    t.string   "type"
    t.string   "default_time_zone"
  end

end

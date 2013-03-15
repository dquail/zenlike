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

ActiveRecord::Schema.define(:version => 20130315041115) do

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
    t.string   "summary"
  end

  create_table "meeting_requests", :force => true do |t|
    t.integer  "meeting_thread_id"
    t.string   "location"
    t.string   "participants"
    t.text     "description"
    t.string   "datetime"
    t.string   "time_zone"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.datetime "start_date_time"
    t.datetime "end_date_time"
    t.string   "summary"
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

  create_table "plans", :force => true do |t|
    t.string   "name"
    t.decimal  "price"
    t.integer  "credits"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "stripe_id"
  end

  create_table "subscriptions", :force => true do |t|
    t.integer  "plan_id"
    t.integer  "user_id"
    t.string   "stripe_customer_token"
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
    t.string   "last_4_digits"
    t.string   "status",                :default => "active"
    t.integer  "available_credits",     :default => 3
  end

  create_table "users", :force => true do |t|
    t.string   "default_time_zone"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "roles_mask"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end

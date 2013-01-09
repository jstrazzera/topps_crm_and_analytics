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

ActiveRecord::Schema.define(:version => 20121116200139) do

  create_table "ab_test_caches", :force => true do |t|
    t.string   "test_name"
    t.string   "app"
    t.integer  "fan_id"
    t.string   "group"
    t.boolean  "success"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "analytics_caches", :force => true do |t|
    t.string   "kind"
    t.time     "time"
    t.integer  "int_data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.text     "hash_data"
    t.date     "date"
  end

  create_table "black_listed_emails", :force => true do |t|
    t.string   "method"
    t.string   "address"
    t.text     "reason"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "crm_queue_items", :force => true do |t|
    t.string   "app"
    t.string   "destinaiton_email_address"
    t.string   "data"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.boolean  "completed"
    t.string   "email_type"
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
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "invalid_emails", :force => true do |t|
    t.string   "address"
    t.string   "reason"
    t.datetime "date"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "ma_bandit_records", :force => true do |t|
    t.integer  "ma_bandit_id"
    t.integer  "fan_id"
    t.boolean  "success"
    t.string   "group"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "ma_bandits", :force => true do |t|
    t.string   "name"
    t.string   "app"
    t.string   "groups"
    t.datetime "start_date"
    t.datetime "end_date"
    t.text     "results"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "current_best_group"
  end

  create_table "mailing_list_emails", :force => true do |t|
    t.string   "address"
    t.integer  "team_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "message_logs", :force => true do |t|
    t.string   "method"
    t.string   "kind"
    t.integer  "fan_id"
    t.boolean  "success"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "blurb_id"
    t.text     "data"
    t.string   "app"
    t.string   "version"
    t.boolean  "sent"
  end

  create_table "messages", :force => true do |t|
    t.boolean  "attempted"
    t.boolean  "success"
    t.string   "type"
    t.string   "message"
    t.string   "batch_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "nfl_games", :force => true do |t|
    t.integer  "team_1_id"
    t.integer  "team_2_id"
    t.datetime "game_start"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "teams", :force => true do |t|
    t.string   "color"
    t.string   "name"
    t.string   "city"
    t.datetime "promo_start_date"
    t.datetime "promo_end_date"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.text     "welcome_email_subject"
    t.text     "welcome_email_body"
    t.string   "welcome_message_avatar"
  end

  create_table "templates", :force => true do |t|
    t.string   "target"
    t.text     "subject"
    t.text     "body"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "app"
    t.boolean  "archived"
    t.string   "version"
    t.string   "deep_link_key"
    t.string   "deep_link_value"
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

end

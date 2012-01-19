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

ActiveRecord::Schema.define(:version => 20120118175429) do

  create_table "authorizations", :force => true do |t|
    t.string   "provider"
    t.string   "uid"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "blogs", :force => true do |t|
    t.string   "title"
    t.string   "description"
    t.string   "url"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contributions", :force => true do |t|
    t.integer  "user_id"
    t.integer  "scope_id"
    t.integer  "target_id"
    t.string   "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "countries", :force => true do |t|
    t.string   "name"
    t.string   "short"
    t.string   "description"
    t.integer  "pcregion_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "feedback", :force => true do |t|
    t.string   "subject"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "jobs", :force => true do |t|
    t.integer  "staff_id"
    t.integer  "position_id"
    t.date     "start"
    t.date     "end"
    t.string   "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "memberships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pages", :force => true do |t|
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.string   "title"
    t.string   "description"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "system",      :default => false
  end

  create_table "pcregions", :force => true do |t|
    t.string   "name"
    t.string   "short"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "permissions", :force => true do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.integer  "scope_id"
    t.integer  "privilege_id"
    t.string   "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "target_id"
  end

  create_table "positions", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.text     "qualifications"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "privileges", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "regions", :force => true do |t|
    t.string   "name"
    t.string   "short"
    t.integer  "parent_id"
    t.integer  "type_id"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "country_id"
  end

  create_table "regiontypes", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "scopes", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
  end

  create_table "sectors", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "staff", :force => true do |t|
    t.integer  "user_id"
    t.integer  "site_id"
    t.string   "building"
    t.string   "office"
    t.string   "floor"
    t.time     "morning_open"
    t.time     "morning_close"
    t.time     "afternoon_open"
    t.time     "afternoon_close"
    t.string   "details"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "bio"
    t.integer  "country_id"
    t.string   "email2"
    t.string   "phone1"
    t.string   "phone2"
    t.string   "site"
  end

  create_table "volunteers", :force => true do |t|
    t.integer  "user_id"
    t.integer  "pc_id"
    t.text     "emphasis"
    t.text     "projects"
    t.integer  "stage_id"
    t.integer  "cos_date"
    t.string   "local_name"
    t.integer  "site_id"
    t.integer  "sector_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "start"
  end

  create_table "websites", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "url"
    t.integer  "language_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end

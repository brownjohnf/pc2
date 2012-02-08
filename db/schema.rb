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

ActiveRecord::Schema.define(:version => 20120208140440) do

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

  create_table "case_studies", :force => true do |t|
    t.string   "title"
    t.integer  "photo_id"
    t.integer  "language_id"
    t.text     "summary"
    t.text     "context"
    t.text     "approach"
    t.text     "results"
    t.text     "challenges"
    t.text     "lessons_learned"
    t.text     "next_steps"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "country"
  end

  create_table "contributions", :force => true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "contributable_id"
    t.string   "contributable_type"
  end

  create_table "documents", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "user_id"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "language_id"
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

  create_table "identities", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "imports", :force => true do |t|
    t.string   "name"
    t.string   "comment"
    t.integer  "scope_id"
    t.boolean  "processed"
    t.string   "csv_file_name"
    t.string   "csv_content_type"
    t.integer  "csv_file_size"
    t.datetime "csv_updated_at"
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

  create_table "languages", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "code"
  end

  create_table "libraries", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "country"
  end

  create_table "memberships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "moments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "photo_id"
    t.date     "datapoint"
    t.string   "title"
    t.text     "summary"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "country"
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
    t.integer  "photo_id"
    t.integer  "language_id"
    t.string   "country"
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

  create_table "photos", :force => true do |t|
    t.string   "title"
    t.string   "description"
    t.string   "attribution"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.integer  "user_id"
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
    t.string   "country"
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

  create_table "settings", :force => true do |t|
    t.string   "property"
    t.string   "value"
    t.string   "explanation"
    t.string   "comment"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sites", :force => true do |t|
    t.string   "name"
    t.integer  "region_id"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stacks", :force => true do |t|
    t.integer  "library_id"
    t.integer  "user_id"
    t.string   "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "stackable_id"
    t.string   "stackable_type"
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
    t.string   "country"
  end

  create_table "stages", :force => true do |t|
    t.string   "name"
    t.date     "arrival"
    t.date     "swear_in"
    t.date     "cos"
    t.string   "pc_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       :limit => 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "bio"
    t.string   "email2"
    t.string   "phone1"
    t.string   "phone2"
    t.string   "site"
    t.integer  "photo_id"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "country"
  end

  create_table "volunteers", :force => true do |t|
    t.integer  "user_id"
    t.integer  "pc_id"
    t.text     "emphasis"
    t.text     "projects"
    t.integer  "stage_id"
    t.string   "local_name"
    t.integer  "site_id"
    t.integer  "sector_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "cos_date"
    t.string   "country"
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

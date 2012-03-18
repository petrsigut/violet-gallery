# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110220163731) do

  create_table "authors", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "carts", :force => true do |t|
    t.string   "phone"
    t.string   "email"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "address"
    t.string   "status"
  end

  create_table "ckeditor_assets", :force => true do |t|
    t.string   "data_file_name",                                 :null => false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    :limit => 30
    t.string   "type",              :limit => 25
    t.string   "guid",              :limit => 10
    t.integer  "locale",            :limit => 1,  :default => 0
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], :name => "fk_assetable"
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], :name => "idx_assetable_type"
  add_index "ckeditor_assets", ["user_id"], :name => "fk_user"

  create_table "comments", :force => true do |t|
    t.string   "name",       :limit => 35, :null => false
    t.text     "msg",                      :null => false
    t.integer  "photo_id",                 :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "ip"
    t.boolean  "approve"
  end

  create_table "counter_visitors", :force => true do |t|
    t.string   "ip"
    t.string   "browser"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "counters", :force => true do |t|
    t.integer  "count",      :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", :force => true do |t|
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "guestbooks", :force => true do |t|
    t.string   "name"
    t.string   "web"
    t.string   "ip"
    t.text     "msg"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ordered_photos", :force => true do |t|
    t.integer  "photo_id",                                                   :null => false
    t.integer  "cart_id",                                                    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "price",         :limit => 10, :precision => 10, :scale => 0
    t.integer  "print_size_id"
  end

  create_table "photos", :force => true do |t|
    t.string   "title",        :limit => 100
    t.integer  "view",                                                       :default => 0, :null => false
    t.integer  "x_dim"
    t.integer  "y_dim"
    t.datetime "created_at"
    t.datetime "last_comment"
    t.datetime "last_view"
    t.string   "ip",           :limit => 16
    t.datetime "updated_at"
    t.integer  "section_id"
    t.integer  "price",        :limit => 10,  :precision => 10, :scale => 0
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "publish_at"
    t.integer  "width"
    t.integer  "height"
    t.text     "note"
    t.integer  "author_id"
  end

  create_table "print_sizes", :force => true do |t|
    t.string   "size"
    t.integer  "price",      :limit => 10, :precision => 10, :scale => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "section_translations", :force => true do |t|
    t.integer  "section_id"
    t.string   "locale"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "text"
  end

  add_index "section_translations", ["section_id"], :name => "index_section_translations_on_section_id"

  create_table "sections", :force => true do |t|
    t.string   "title"
    t.integer  "not_comment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
    t.boolean  "builtin",      :default => false
    t.string   "builtin_name"
    t.text     "text"
    t.string   "subtitle"
    t.integer  "parent_id"
    t.boolean  "virtual",      :default => false
    t.string   "hardcoded",    :default => "0"
    t.boolean  "folder",       :default => false
    t.boolean  "show_menu",    :default => true
    t.string   "virtual_url"
    t.string   "virtual_name"
    t.string   "cssclass",     :default => "nowrap"
    t.string   "order",        :default => "DESC"
    t.boolean  "published",    :default => true
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "settings", :force => true do |t|
    t.string   "name"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "textbox_translations", :force => true do |t|
    t.integer  "textbox_id"
    t.string   "locale"
    t.string   "title"
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "textbox_translations", ["textbox_id"], :name => "index_textbox_translations_on_textbox_id"

  create_table "textboxes", :force => true do |t|
    t.string   "title"
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "hardcoded_name"
    t.boolean  "publish",        :default => true
  end

  create_table "users", :force => true do |t|
    t.string   "login",                              :null => false
    t.string   "email"
    t.string   "crypted_password",                   :null => false
    t.string   "password_salt",                      :null => false
    t.string   "persistence_token",                  :null => false
    t.string   "single_access_token",                :null => false
    t.string   "perishable_token",                   :null => false
    t.integer  "login_count",         :default => 0, :null => false
    t.integer  "failed_login_count",  :default => 0, :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "second_name"
  end

end

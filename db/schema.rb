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

ActiveRecord::Schema.define(:version => 20120108205721) do

  create_table "contents", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "user_id"
    t.integer  "position"
    t.string   "icon"
    t.string   "icon_credit"
    t.integer  "topic_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "contents", ["topic_id", "position"], :name => "index_contents_on_topic_id_and_position"

  create_table "items", :force => true do |t|
    t.integer  "item_type_id"
    t.integer  "content_id"
    t.integer  "position"
    t.text     "body"
    t.string   "style"
    t.integer  "size"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "note"
  end

  add_index "items", ["content_id", "position"], :name => "index_items_on_content_id_and_position"

  create_table "screens", :force => true do |t|
    t.string   "title"
    t.integer  "user_id"
    t.integer  "topic_id"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "screens", ["topic_id", "position"], :name => "index_screens_on_topic_id_and_position"

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "topics", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "user_id"
    t.string   "icon"
    t.string   "ancestry"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "icon_credit"
  end

  add_index "topics", ["ancestry"], :name => "index_topics_on_ancestry"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "hashed_password"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end

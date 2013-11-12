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

ActiveRecord::Schema.define(:version => 20131112005356) do

  create_table "best_seller_list_books", :force => true do |t|
    t.integer  "book_id"
    t.integer  "best_seller_list_id"
    t.integer  "rank"
    t.integer  "number_weeks"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "best_seller_lists", :force => true do |t|
    t.string   "week"
    t.string   "category"
    t.string   "list_source"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "book_users", :force => true do |t|
    t.integer  "user_id"
    t.integer  "book_id"
    t.integer  "vote",        :default => 0
    t.boolean  "purchased",   :default => false
    t.boolean  "read",        :default => false
    t.integer  "star_rating"
    t.string   "bucket"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  create_table "books", :force => true do |t|
    t.string   "title"
    t.string   "author"
    t.string   "isbn10"
    t.string   "isbn13"
    t.string   "asin"
    t.string   "amazon_ref"
    t.string   "amazon_img"
    t.string   "img_height"
    t.string   "img_width"
    t.string   "price"
    t.text     "description"
    t.string   "publisher"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "identities", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end

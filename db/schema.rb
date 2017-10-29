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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20171028220710) do

  create_table "document_columns", force: :cascade do |t|
    t.string   "name",                    null: false
    t.integer  "meaning",     default: 0, null: false
    t.integer  "document_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["document_id"], name: "index_document_columns_on_document_id"
  end

  create_table "documents", force: :cascade do |t|
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "input_file_file_name"
    t.string   "input_file_content_type"
    t.integer  "input_file_file_size"
    t.datetime "input_file_updated_at"
  end

  create_table "teryt_locations", force: :cascade do |t|
    t.string   "address"
    t.float    "geomx"
    t.float    "geomy"
    t.string   "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end

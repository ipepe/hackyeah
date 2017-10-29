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

ActiveRecord::Schema.define(version: 20171028193456) do

  create_table "teryt_locations", force: :cascade do |t|
    t.string   "street",     null: false
    t.float    "geomx",      null: false
    t.float    "geomy",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["street"], name: "index_teryt_locations_on_street"
  end

  create_table "uploads", force: :cascade do |t|
    t.integer  "status",                      default: 0, null: false
    t.datetime "time_started_processing"
    t.datetime "time_ended_processing"
    t.integer  "rows_in_input_file",          default: 0, null: false
    t.integer  "successfully_processed_rows", default: 0, null: false
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.string   "input_file_file_name"
    t.string   "input_file_content_type"
    t.integer  "input_file_file_size"
    t.datetime "input_file_updated_at"
    t.string   "output_file_file_name"
    t.string   "output_file_content_type"
    t.integer  "output_file_file_size"
    t.datetime "output_file_updated_at"
    t.string   "errors_file_file_name"
    t.string   "errors_file_content_type"
    t.integer  "errors_file_file_size"
    t.datetime "errors_file_updated_at"
  end

end

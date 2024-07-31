# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_07_31_200852) do
  create_table "availabilities", force: :cascade do |t|
    t.integer "engineer_id", null: false
    t.integer "block_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["block_id"], name: "index_availabilities_on_block_id"
    t.index ["engineer_id"], name: "index_availabilities_on_engineer_id"
  end

  create_table "blocks", force: :cascade do |t|
    t.integer "day_id", null: false
    t.integer "engineer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "start_time"
    t.datetime "end_time"
    t.index ["day_id"], name: "index_blocks_on_day_id"
    t.index ["engineer_id"], name: "index_blocks_on_engineer_id"
  end

  create_table "days", force: :cascade do |t|
    t.string "label"
    t.integer "week_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["week_id"], name: "index_days_on_week_id"
  end

  create_table "engineers", force: :cascade do |t|
    t.string "name"
    t.string "color"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "services", force: :cascade do |t|
    t.string "name"
    t.date "start_date"
    t.date "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "weeks", force: :cascade do |t|
    t.string "label"
    t.date "start_date"
    t.date "end_date"
    t.integer "service_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "number"
    t.integer "year"
    t.index ["service_id"], name: "index_weeks_on_service_id"
  end

  add_foreign_key "availabilities", "blocks"
  add_foreign_key "availabilities", "engineers"
  add_foreign_key "blocks", "days"
  add_foreign_key "blocks", "engineers"
  add_foreign_key "days", "weeks"
  add_foreign_key "weeks", "services"
end

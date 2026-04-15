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

ActiveRecord::Schema[7.0].define(version: 2026_04_15_050958) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "daily_result_statistics", force: :cascade do |t|
    t.date "date", null: false
    t.string "subject", null: false
    t.integer "daily_low", null: false
    t.integer "daily_high", null: false
    t.integer "result_count", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["date", "subject"], name: "index_daily_result_statistics_on_date_and_subject", unique: true
  end

  create_table "monthly_averages", force: :cascade do |t|
    t.date "computed_on", null: false
    t.decimal "avg_daily_high", precision: 8, scale: 2, null: false
    t.decimal "avg_daily_low", precision: 8, scale: 2, null: false
    t.integer "total_result_count", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["computed_on"], name: "index_monthly_averages_on_computed_on", unique: true
  end

  create_table "test_results", force: :cascade do |t|
    t.string "student_name", null: false
    t.string "subject", null: false
    t.integer "marks", null: false
    t.datetime "timestamp", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subject", "timestamp"], name: "index_test_results_on_subject_and_timestamp"
  end

end

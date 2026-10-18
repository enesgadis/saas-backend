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

ActiveRecord::Schema[8.0].define(version: 2026_10_18_153000) do
  create_table "tickets", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.string "status", default: "open", null: false
    t.text "ai_draft_reply"
    t.string "ai_suggested_action"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "customer_name"
    t.string "customer_email"
    t.string "department"
    t.text "internal_note"
    t.integer "time_saved_minutes", default: 0
  end
end

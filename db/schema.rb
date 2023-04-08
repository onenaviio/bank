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

ActiveRecord::Schema.define(version: 2023_04_08_033217) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "number", null: false
    t.integer "currency", null: false
    t.float "balance", default: 0.0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "service_rate_id", null: false
    t.index ["service_rate_id"], name: "index_accounts_on_service_rate_id"
    t.index ["user_id"], name: "index_accounts_on_user_id"
  end

  create_table "cards", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.string "name", null: false
    t.string "number", null: false
    t.date "expires_date", null: false
    t.string "cvv", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_cards_on_account_id"
  end

  create_table "history_operations", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.bigint "card_id"
    t.bigint "user_id"
    t.string "title", null: false
    t.float "payload", null: false
    t.datetime "processed_at", null: false
    t.integer "operation_type", null: false
    t.jsonb "extra_data", default: {}
    t.index ["account_id"], name: "index_history_operations_on_account_id"
    t.index ["card_id"], name: "index_history_operations_on_card_id"
    t.index ["user_id"], name: "index_history_operations_on_user_id"
  end

  create_table "service_rates", force: :cascade do |t|
    t.string "title", null: false
    t.float "service_per_month", default: 0.0, null: false
    t.string "c2c_commission_type", null: false
    t.float "c2c_commission_value", default: 0.0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "patronymic", null: false
    t.string "phone", null: false
    t.string "email", null: false
    t.string "password", null: false
    t.date "birthday", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "accounts", "service_rates"
  add_foreign_key "accounts", "users", on_delete: :cascade
  add_foreign_key "cards", "accounts"
  add_foreign_key "history_operations", "accounts", on_delete: :cascade
  add_foreign_key "history_operations", "cards"
  add_foreign_key "history_operations", "users"
end

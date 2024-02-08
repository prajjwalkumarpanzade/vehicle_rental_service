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

ActiveRecord::Schema[7.1].define(version: 2024_02_06_075026) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum "fuel_type", ["petrol", "diesel", "electric", "CNG"]
  create_enum "role", ["admin", "user"]
  create_enum "status", ["available", "booked"]
  create_enum "v_type", ["car", "bike", "jeep"]

  create_table "rentals", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "vehicle_id", null: false
    t.string "destination"
    t.datetime "start_date"
    t.datetime "expected_end_date"
    t.datetime "actual_end_date"
    t.string "pickup_point"
    t.integer "total_bill"
    t.integer "extra_cost"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_rentals_on_user_id"
    t.index ["vehicle_id"], name: "index_rentals_on_vehicle_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "phone_no"
    t.string "email"
    t.string "password_digest"
    t.string "address"
    t.enum "role", default: "user", null: false, enum_type: "role"
    t.string "d_license_no"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "vehicles", force: :cascade do |t|
    t.enum "v_type", enum_type: "v_type"
    t.string "vehicle_no"
    t.string "make"
    t.string "model"
    t.integer "year"
    t.enum "fuel_type", enum_type: "fuel_type"
    t.integer "mileage"
    t.float "price_per_hrs"
    t.enum "status", enum_type: "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "rentals", "users"
  add_foreign_key "rentals", "vehicles"
end

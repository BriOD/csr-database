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

ActiveRecord::Schema.define(version: 20160822142444) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "address_books", force: :cascade do |t|
    t.string   "address_1"
    t.string   "address_2"
    t.string   "city"
    t.string   "state"
    t.integer  "zipcode"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "companies", force: :cascade do |t|
    t.integer  "customer_id"
    t.string   "name"
    t.string   "contact_first_name"
    t.string   "contact_last_name"
    t.string   "contact_email"
    t.string   "billing_email"
    t.integer  "address_book_id"
    t.string   "main_number"
    t.string   "contact_number"
    t.string   "fax"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "customers", force: :cascade do |t|
    t.integer  "ip_address_id"
    t.integer  "address_book_id"
    t.integer  "account_number"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "home_phone"
    t.string   "cell_phone"
    t.string   "work_phone"
    t.text     "notes"
    t.boolean  "active",          default: true
    t.string   "email"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "ip_addresses", force: :cascade do |t|
    t.integer  "ip_range_id",                 null: false
    t.integer  "customer_id"
    t.string   "ip",          default: "",    null: false
    t.boolean  "reserved",    default: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "ip_ranges", force: :cascade do |t|
    t.string   "network",    default: "", null: false
    t.string   "gateway",    default: "", null: false
    t.integer  "service_id", default: 1,  null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "leases", force: :cascade do |t|
    t.integer  "customer_id"
    t.string   "modem_manufacturer"
    t.string   "modem_model"
    t.string   "modem_serial"
    t.string   "modem_mac"
    t.string   "router_manufacturer"
    t.string   "router_model"
    t.string   "router_serial"
    t.string   "router_mac"
    t.boolean  "tr069",               default: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  create_table "services", force: :cascade do |t|
    t.string   "icon",       default: "", null: false
    t.string   "main_type",  default: "", null: false
    t.string   "main_name",  default: "", null: false
    t.string   "sub_type"
    t.string   "sub_name"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name",             default: "", null: false
    t.string   "last_name",              default: "", null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "provider"
    t.string   "uid"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "webspaces", force: :cascade do |t|
    t.integer  "customer_id"
    t.boolean  "active",      default: false
    t.string   "url"
    t.string   "username"
    t.string   "password"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

end

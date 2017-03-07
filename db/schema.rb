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


ActiveRecord::Schema.define(version: 20170307220602) do

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lots", force: :cascade do |t|
    t.string   "name"
    t.integer  "sown_at"
    t.string   "material"
    t.decimal  "hectares"
    t.integer  "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_lots_on_project_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "manager"
    t.string   "image"
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "password_digest"
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "image"
  end

  create_table "valorizations", force: :cascade do |t|
    t.integer  "lot_id"
    t.integer  "variable_id"
    t.date     "assigned_at"
    t.integer  "amount"
    t.decimal  "unit_cost"
    t.decimal  "subtotal"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["lot_id"], name: "index_valorizations_on_lot_id"
    t.index ["variable_id"], name: "index_valorizations_on_variable_id"
  end

  create_table "variables", force: :cascade do |t|
    t.string   "measurement_unit"
    t.decimal  "unit_cost"
    t.string   "name"
    t.integer  "category_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["category_id"], name: "index_variables_on_category_id"
  end

end

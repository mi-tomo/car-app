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

ActiveRecord::Schema.define(version: 2019_09_13_045119) do

  create_table "carnames", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "maker_name"
    t.string "maker"
    t.string "name"
    t.string "address"
  end

  create_table "products", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "maker"
    t.string "name"
    t.string "model"
    t.string "exhaust"
    t.string "modelyear"
    t.string "color"
    t.float "distance"
    t.string "price"
    t.string "repare"
    t.string "evaluation"
    t.string "unit"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end

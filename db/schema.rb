# encoding: UTF-8
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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121227202357) do

  create_table "businesses", :force => true do |t|
    t.string   "name"
    t.string   "logo"
    t.text     "description"
    t.integer  "country_id"
    t.string   "legal_name"
    t.boolean  "featured"
    t.integer  "currency_id"
    t.text     "notes"
    t.integer  "billing_address_id"
    t.integer  "mailing_address_id"
    t.string   "state"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "crypted_password"
    t.string   "salt"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "activation_state"
    t.string   "activation_token"
    t.string   "activation_token_expires_at"
    t.string   "reset_password_token"
    t.string   "reset_password_token_expires_at"
    t.string   "reset_password_email_sent_at"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

end

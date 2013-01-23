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

ActiveRecord::Schema.define(:version => 20130123032438) do

  create_table "authentications", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.string   "provider",   :null => false
    t.string   "uid",        :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "authentications", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.string   "provider",   :null => false
    t.string   "uid",        :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

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
    t.string   "subdomain",          :null => false
    t.string   "master_pin"
  end

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
    t.string   "subdomain",          :null => false
    t.string   "master_pin"
  end

  create_table "locations", :force => true do |t|
    t.integer  "business_id"
    t.boolean  "is_mobile"
    t.string   "name"
    t.string   "street_address"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "phone_number"
    t.text     "description"
    t.string   "featured_image"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "city",           :null => false
    t.string   "state",          :null => false
    t.string   "country",        :null => false
    t.string   "postal_code",    :null => false
  end

  create_table "locations", :force => true do |t|
    t.integer  "business_id"
    t.boolean  "is_mobile"
    t.string   "name"
    t.string   "street_address"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "phone_number"
    t.text     "description"
    t.string   "featured_image"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "city",           :null => false
    t.string   "state",          :null => false
    t.string   "country",        :null => false
    t.string   "postal_code",    :null => false
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "roles", ["name", "resource_type", "resource_id"], :name => "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name", "resource_type", "resource_id"], :name => "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], :name => "index_roles_on_name"
  add_index "roles", ["name"], :name => "index_roles_on_name"

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "roles", ["name", "resource_type", "resource_id"], :name => "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name", "resource_type", "resource_id"], :name => "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], :name => "index_roles_on_name"
  add_index "roles", ["name"], :name => "index_roles_on_name"

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
    t.string   "authentication_token"
    t.date     "date_of_birth"
    t.string   "phone_number"
    t.boolean  "is_male"
    t.string   "account_status"
  end

  add_index "users", ["authentication_token"], :name => "index_users_on_authentication_token", :unique => true
  add_index "users", ["authentication_token"], :name => "index_users_on_authentication_token", :unique => true

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
    t.string   "authentication_token"
    t.date     "date_of_birth"
    t.string   "phone_number"
    t.boolean  "is_male"
    t.string   "account_status"
  end

  add_index "users", ["authentication_token"], :name => "index_users_on_authentication_token", :unique => true
  add_index "users", ["authentication_token"], :name => "index_users_on_authentication_token", :unique => true

  create_table "users_roles", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], :name => "index_users_roles_on_user_id_and_role_id"
  add_index "users_roles", ["user_id", "role_id"], :name => "index_users_roles_on_user_id_and_role_id"

  create_table "users_roles", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], :name => "index_users_roles_on_user_id_and_role_id"
  add_index "users_roles", ["user_id", "role_id"], :name => "index_users_roles_on_user_id_and_role_id"

end

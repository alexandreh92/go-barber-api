# frozen_string_literal: true

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

ActiveRecord::Schema.define(version: 20_200_311_170_622) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'appointments', force: :cascade do |t|
    t.datetime 'date'
    t.bigint 'user_id'
    t.bigint 'provider_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.datetime 'cancelled_at'
    t.index ['provider_id'], name: 'index_appointments_on_provider_id'
    t.index ['user_id'], name: 'index_appointments_on_user_id'
  end

  create_table 'jwt_blacklist', force: :cascade do |t|
    t.string 'jti', null: false
    t.index ['jti'], name: 'index_jwt_blacklist_on_jti'
  end

  create_table 'notifications', force: :cascade do |t|
    t.string 'content'
    t.bigint 'user_id'
    t.bigint 'provider_id'
    t.boolean 'read', default: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['provider_id'], name: 'index_notifications_on_provider_id'
    t.index ['user_id'], name: 'index_notifications_on_user_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'name'
    t.boolean 'provider', default: false
    t.string 'avatar'
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token',
                                      unique: true
  end
end

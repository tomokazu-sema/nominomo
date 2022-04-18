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

ActiveRecord::Schema[7.0].define(version: 20_220_415_023_606) do
  create_table 'event_places', charset: 'utf8', force: :cascade do |t|
    t.bigint 'event_id', null: false
    t.string 'place', null: false
    t.string 'url'
    t.text 'comment'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['event_id'], name: 'index_event_places_on_event_id'
  end

  create_table 'events', charset: 'utf8', force: :cascade do |t|
    t.bigint 'user_id'
    t.string 'uid', null: false
    t.string 'title', null: false
    t.string 'password_digest'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['uid'], name: 'index_events_on_uid', unique: true
    t.index ['user_id'], name: 'index_events_on_user_id'
  end

  create_table 'hosts', charset: 'utf8', force: :cascade do |t|
    t.bigint 'event_id', null: false
    t.string 'uid', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['event_id'], name: 'index_hosts_on_event_id'
    t.index ['uid'], name: 'index_hosts_on_uid', unique: true
  end

  create_table 'users', charset: 'utf8', force: :cascade do |t|
    t.string 'uid', null: false
    t.string 'name', null: false
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
    t.index ['uid'], name: 'index_users_on_uid', unique: true
  end

  add_foreign_key 'event_places', 'events'
  add_foreign_key 'events', 'users'
  add_foreign_key 'hosts', 'events'
end

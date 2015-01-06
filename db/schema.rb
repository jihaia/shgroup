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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150101042116) do

  create_table "endpoints", id: false, force: true do |t|
    t.string  "endpointId",     limit: 50,                  null: false
    t.string  "token",          limit: 32,                  null: false
    t.string  "interfaceType",  limit: 20,                  null: false
    t.string  "direction",      limit: 10,                  null: false
    t.string  "brand",          limit: 20
    t.string  "url",            limit: 400
    t.string  "username",       limit: 40
    t.string  "password",       limit: 40
    t.integer "revisionNumber",             default: 1,     null: false
    t.boolean "isDestroyed",                default: false, null: false
  end

  create_table "keymaps", id: false, force: true do |t|
    t.string  "keymapId",       limit: 32,                  null: false
    t.string  "endpointId",     limit: 40,                  null: false
    t.string  "interfaceType",  limit: 20,                  null: false
    t.string  "direction",      limit: 10
    t.string  "brand",          limit: 20
    t.string  "url",            limit: 400
    t.string  "username",       limit: 50
    t.string  "password",       limit: 50
    t.string  "mode",           limit: 20,                  null: false
    t.integer "revisionNumber",             default: 1,     null: false
    t.boolean "isDestroyed",                default: false, null: false
  end

  create_table "properties", id: false, force: true do |t|
    t.string  "propertyNumber", limit: 20,                 null: false
    t.string  "propertyCode",   limit: 40,                 null: false
    t.string  "brand",          limit: 20,                 null: false
    t.string  "propertyName",   limit: 50,                 null: false
    t.date    "openedOn"
    t.string  "address",        limit: 60
    t.string  "city",           limit: 40
    t.string  "stateProvince",  limit: 40
    t.string  "countryCode",    limit: 2
    t.string  "timezone",       limit: 10
    t.string  "emailAddress",   limit: 60
    t.string  "telephone",      limit: 20
    t.integer "revisionNumber",            default: 1,     null: false
    t.boolean "isDestroyed",               default: false, null: false
  end

end

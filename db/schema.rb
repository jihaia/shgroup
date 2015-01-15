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

ActiveRecord::Schema.define(version: 20150112044947) do

  create_table "addresses", id: false, force: :cascade do |t|
    t.string  "addressId",      limit: 32,                  null: false
    t.string  "emailAddress",   limit: 100,                 null: false
    t.string  "addressType",    limit: 40
    t.string  "city",           limit: 50
    t.string  "countryCode",    limit: 2
    t.string  "line1",          limit: 50
    t.string  "line2",          limit: 50
    t.string  "line3",          limit: 50
    t.string  "line4",          limit: 50
    t.string  "postalCode",     limit: 20
    t.string  "stateProvince",  limit: 50
    t.boolean "isPrimary",      limit: 1,   default: false, null: false
    t.integer "revisionNumber", limit: 4,   default: 1,     null: false
    t.boolean "isDestroyed",    limit: 1,   default: false, null: false
  end

  create_table "endpoints", id: false, force: :cascade do |t|
    t.string  "endpointId",     limit: 50,                          null: false
    t.string  "mode",           limit: 20,  default: "development", null: false
    t.string  "token",          limit: 32,                          null: false
    t.string  "interfaceType",  limit: 20
    t.string  "direction",      limit: 10
    t.string  "brand",          limit: 20
    t.string  "url",            limit: 400
    t.string  "username",       limit: 40
    t.string  "password",       limit: 40
    t.integer "revisionNumber", limit: 4,   default: 1,             null: false
    t.boolean "isDestroyed",    limit: 1,   default: false,         null: false
  end

  create_table "guests", id: false, force: :cascade do |t|
    t.string  "guestId",             limit: 32,                  null: false
    t.string  "brand",               limit: 20,                  null: false
    t.string  "emailAddress",        limit: 100,                 null: false
    t.date    "lastStayOn"
    t.string  "lastStayProperty",    limit: 20
    t.date    "lastCommunicationOn"
    t.integer "lifetimeValue",       limit: 4,   default: 0,     null: false
    t.integer "revisionNumber",      limit: 4,   default: 1,     null: false
    t.boolean "isDestroyed",         limit: 1,   default: false, null: false
  end

  create_table "incidents", id: false, force: :cascade do |t|
    t.string "referenceCode",  limit: 10,    null: false
    t.string "guestId",        limit: 20,    null: false
    t.string "propertyNumber", limit: 20,    null: false
    t.string "incidentType",   limit: 40,    null: false
    t.string "problemArea",    limit: 40
    t.text   "description",    limit: 65535
    t.string "status",         limit: 40,    null: false
    t.date   "startedOn"
    t.date   "reportedOn",                   null: false
    t.date   "resolvedOn"
    t.string "assignedTo",     limit: 100
  end

  create_table "keymaps", id: false, force: :cascade do |t|
    t.string  "keymapId",       limit: 32,                  null: false
    t.string  "endpointId",     limit: 40,                  null: false
    t.string  "interfaceType",  limit: 20,                  null: false
    t.string  "direction",      limit: 10
    t.string  "brand",          limit: 20
    t.string  "url",            limit: 400
    t.string  "username",       limit: 50
    t.string  "password",       limit: 50
    t.string  "mode",           limit: 20,                  null: false
    t.integer "revisionNumber", limit: 4,   default: 1,     null: false
    t.boolean "isDestroyed",    limit: 1,   default: false, null: false
  end

  create_table "people", id: false, force: :cascade do |t|
    t.string  "emailAddress",     limit: 100,                 null: false
    t.string  "firstName",        limit: 40
    t.string  "lastName",         limit: 40
    t.string  "languageCode",     limit: 10
    t.date    "bornOn"
    t.integer "birthMonth",       limit: 4
    t.integer "birthDay",         limit: 4
    t.integer "anniversaryMonth", limit: 4
    t.integer "anniversaryDay",   limit: 4
    t.string  "currency",         limit: 10
    t.integer "revisionNumber",   limit: 4,   default: 1,     null: false
    t.boolean "isDestroyed",      limit: 1,   default: false, null: false
  end

  create_table "properties", id: false, force: :cascade do |t|
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
    t.integer "revisionNumber", limit: 4,  default: 1,     null: false
    t.boolean "isDestroyed",    limit: 1,  default: false, null: false
  end

  create_table "sequences", id: false, force: :cascade do |t|
    t.string  "sequence_code", limit: 100,             null: false
    t.string  "prefix",        limit: 10
    t.integer "padding",       limit: 4,   default: 8, null: false
    t.integer "value",         limit: 4,   default: 1, null: false
  end

  add_index "sequences", ["sequence_code"], name: "index_sequences_on_sequence_code", unique: true, using: :btree

end

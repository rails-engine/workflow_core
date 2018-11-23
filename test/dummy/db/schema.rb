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

ActiveRecord::Schema.define(version: 2018_09_22_095933) do

  create_table "fields", force: :cascade do |t|
    t.string "name", null: false
    t.integer "accessibility", null: false
    t.text "validations"
    t.text "options"
    t.string "type", null: false
    t.integer "form_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "label", default: ""
    t.string "hint", default: ""
    t.integer "position"
    t.integer "workflow_id"
    t.index ["form_id"], name: "index_fields_on_form_id"
    t.index ["type"], name: "index_fields_on_type"
    t.index ["workflow_id"], name: "index_fields_on_workflow_id"
  end

  create_table "forms", force: :cascade do |t|
    t.string "type", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "attachable_type"
    t.integer "attachable_id"
    t.integer "workflow_id"
    t.index ["attachable_type", "attachable_id"], name: "index_forms_on_attachable_type_and_attachable_id"
    t.index ["type"], name: "index_forms_on_type"
    t.index ["workflow_id"], name: "index_forms_on_workflow_id"
  end

  create_table "group_hierarchies", id: false, force: :cascade do |t|
    t.integer "ancestor_id", null: false
    t.integer "descendant_id", null: false
    t.integer "generations", null: false
    t.index ["ancestor_id", "descendant_id", "generations"], name: "group_anc_desc_idx", unique: true
    t.index ["descendant_id"], name: "group_desc_idx"
  end

  create_table "groups", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "parent_id"
    t.index ["parent_id"], name: "index_groups_on_parent_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.integer "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_users_on_group_id"
  end

  create_table "workflow_instances", force: :cascade do |t|
    t.text "payload"
    t.integer "status", default: 0, null: false
    t.integer "workflow_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "type"
    t.index ["workflow_id"], name: "index_workflow_instances_on_workflow_id"
  end

  create_table "workflow_places", force: :cascade do |t|
    t.integer "input_transition_id"
    t.integer "output_transition_id"
    t.string "type", null: false
    t.integer "workflow_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "uid"
    t.index ["input_transition_id"], name: "index_workflow_places_on_input_transition_id"
    t.index ["output_transition_id"], name: "index_workflow_places_on_output_transition_id"
    t.index ["workflow_id"], name: "index_workflow_places_on_workflow_id"
  end

  create_table "workflow_tokens", force: :cascade do |t|
    t.integer "status", default: 0, null: false
    t.integer "place_id"
    t.integer "previous_id"
    t.integer "instance_id"
    t.integer "workflow_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "type"
    t.index ["instance_id"], name: "index_workflow_tokens_on_instance_id"
    t.index ["place_id"], name: "index_workflow_tokens_on_place_id"
    t.index ["previous_id"], name: "index_workflow_tokens_on_previous_id"
    t.index ["workflow_id"], name: "index_workflow_tokens_on_workflow_id"
  end

  create_table "workflow_transitions", force: :cascade do |t|
    t.string "type", null: false
    t.integer "workflow_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "uid"
    t.text "options"
    t.index ["workflow_id"], name: "index_workflow_transitions_on_workflow_id"
  end

  create_table "workflows", force: :cascade do |t|
    t.string "type", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name", default: ""
    t.text "description", default: ""
  end

end

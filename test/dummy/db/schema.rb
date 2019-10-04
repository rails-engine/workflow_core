# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_10_04_190723) do

  create_table "fields", force: :cascade do |t|
    t.string "name", null: false
    t.integer "accessibility", null: false
    t.text "validations"
    t.text "options"
    t.string "type", null: false
    t.integer "form_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "label", default: ""
    t.string "hint", default: ""
    t.integer "position"
    t.index ["form_id"], name: "index_fields_on_form_id"
    t.index ["type"], name: "index_fields_on_type"
  end

  create_table "forms", force: :cascade do |t|
    t.string "name", null: false
    t.string "type", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "attachable_type"
    t.integer "attachable_id"
    t.index ["attachable_type", "attachable_id"], name: "index_forms_on_attachable_type_and_attachable_id"
    t.index ["name"], name: "index_forms_on_name", unique: true
    t.index ["type"], name: "index_forms_on_type"
  end

  create_table "groups", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.integer "group_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["group_id"], name: "index_users_on_group_id"
  end

  create_table "workflow_instances", force: :cascade do |t|
    t.text "payload"
    t.integer "status", default: 0, null: false
    t.integer "workflow_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "type"
    t.string "creator_type"
    t.integer "creator_id"
    t.index ["creator_type", "creator_id"], name: "index_workflow_instances_on_creator_type_and_creator_id"
    t.index ["workflow_id"], name: "index_workflow_instances_on_workflow_id"
  end

  create_table "workflow_places", force: :cascade do |t|
    t.integer "input_transition_id"
    t.integer "output_transition_id"
    t.string "type", null: false
    t.integer "workflow_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
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
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "type"
    t.text "payload"
    t.string "assignable_type"
    t.integer "assignable_id"
    t.string "forwardable_type"
    t.integer "forwardable_id"
    t.index ["assignable_type", "assignable_id"], name: "index_workflow_tokens_on_assignable_type_and_assignable_id"
    t.index ["forwardable_type", "forwardable_id"], name: "index_workflow_tokens_on_forwardable_type_and_forwardable_id"
    t.index ["instance_id"], name: "index_workflow_tokens_on_instance_id"
    t.index ["place_id"], name: "index_workflow_tokens_on_place_id"
    t.index ["previous_id"], name: "index_workflow_tokens_on_previous_id"
    t.index ["workflow_id"], name: "index_workflow_tokens_on_workflow_id"
  end

  create_table "workflow_transitions", force: :cascade do |t|
    t.string "type", null: false
    t.integer "workflow_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.string "uid"
    t.text "options"
    t.index ["workflow_id"], name: "index_workflow_transitions_on_workflow_id"
  end

  create_table "workflows", force: :cascade do |t|
    t.string "type", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "form_id"
    t.string "name", default: ""
    t.text "description", default: ""
    t.integer "start_place_id"
    t.index ["form_id"], name: "index_workflows_on_form_id"
    t.index ["start_place_id"], name: "index_workflows_on_start_place_id"
  end

  add_foreign_key "fields", "forms"
  add_foreign_key "users", "groups"
  add_foreign_key "workflow_instances", "workflows"
  add_foreign_key "workflow_places", "workflow_transitions", column: "input_transition_id"
  add_foreign_key "workflow_places", "workflow_transitions", column: "output_transition_id"
  add_foreign_key "workflow_places", "workflows"
  add_foreign_key "workflow_tokens", "workflow_instances", column: "instance_id"
  add_foreign_key "workflow_tokens", "workflow_places", column: "place_id"
  add_foreign_key "workflow_tokens", "workflow_tokens", column: "previous_id"
  add_foreign_key "workflow_tokens", "workflows"
  add_foreign_key "workflow_transitions", "workflows"
  add_foreign_key "workflows", "forms"
  add_foreign_key "workflows", "workflow_places", column: "start_place_id"
end

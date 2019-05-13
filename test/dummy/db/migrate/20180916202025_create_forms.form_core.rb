# frozen_string_literal: true

# This migration comes from form_core (originally 20170430190404)
class CreateForms < ActiveRecord::Migration[5.2]
  def change
    create_table :forms do |t|
      t.string :name, null: false, index: { unique: true }
      t.string :type, null: false, index: true

      t.timestamps
    end
  end
end

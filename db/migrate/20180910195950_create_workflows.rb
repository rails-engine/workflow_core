# frozen_string_literal: true

class CreateWorkflows < ActiveRecord::Migration[6.0]
  def change
    create_table :workflows do |t|
      t.string :type, null: false
      t.timestamps
    end
  end
end

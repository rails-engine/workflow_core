# frozen_string_literal: true

class CreateWorkflowInstances < ActiveRecord::Migration[5.2]
  def change
    create_table :workflow_instances do |t|
      t.text :payload
      t.integer :status, null: false, default: 0

      t.references :workflow, foreign_key: true
      t.timestamps
    end
  end
end

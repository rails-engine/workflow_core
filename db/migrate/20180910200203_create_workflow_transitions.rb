# frozen_string_literal: true

class CreateWorkflowTransitions < ActiveRecord::Migration[6.0]
  def change
    create_table :workflow_transitions do |t|
      t.string :type, null: false
      t.references :workflow, foreign_key: true
      t.timestamps
    end
  end
end

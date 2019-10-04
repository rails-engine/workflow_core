# frozen_string_literal: true

class CreateWorkflowPlaces < ActiveRecord::Migration[6.0]
  def change
    create_table :workflow_places do |t|
      t.references :input_transition, foreign_key: { to_table: "workflow_transitions" }
      t.references :output_transition, foreign_key: { to_table: "workflow_transitions" }

      t.string :type, null: false
      t.references :workflow, foreign_key: true
      t.timestamps
    end
  end
end

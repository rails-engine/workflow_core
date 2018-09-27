# frozen_string_literal: true

class CreateWorkflowTokens < ActiveRecord::Migration[5.2]
  def change
    create_table :workflow_tokens do |t|
      t.integer :status, null: false, default: 0

      t.references :place, foreign_key: {to_table: "workflow_places"}
      t.references :previous, foreign_key: {to_table: "workflow_tokens"}

      t.references :instance, foreign_key: {to_table: "workflow_instances"}
      t.references :workflow, foreign_key: true
      t.timestamps
    end
  end
end

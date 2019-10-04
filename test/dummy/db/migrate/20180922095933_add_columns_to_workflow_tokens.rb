# frozen_string_literal: true

class AddColumnsToWorkflowTokens < ActiveRecord::Migration[6.0]
  def change
    change_table :workflow_tokens do |t|
      t.string :type

      t.text :payload

      t.references :assignable, polymorphic: true, index: true
      t.references :forwardable, polymorphic: true, index: true
    end
  end
end

# frozen_string_literal: true

class AddColumnsToWorkflowTokens < ActiveRecord::Migration[5.2]
  def change
    change_table :workflow_tokens do |t|
      t.string :type
    end
  end
end

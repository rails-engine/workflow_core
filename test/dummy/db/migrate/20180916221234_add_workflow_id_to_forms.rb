# frozen_string_literal: true

class AddWorkflowIdToForms < ActiveRecord::Migration[6.0]
  def change
    change_table :forms do |t|
      t.references :workflow, foreign_key: true
    end
  end
end

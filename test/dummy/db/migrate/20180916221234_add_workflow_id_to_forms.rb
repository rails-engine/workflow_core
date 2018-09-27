# frozen_string_literal: true

class AddWorkflowIdToForms < ActiveRecord::Migration[5.2]
  def change
    change_table :forms do |t|
      t.references :workflow, foreign_key: true
    end
  end
end

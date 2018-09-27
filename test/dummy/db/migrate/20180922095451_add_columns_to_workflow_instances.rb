# frozen_string_literal: true

class AddColumnsToWorkflowInstances < ActiveRecord::Migration[5.2]
  def change
    change_table :workflow_instances do |t|
      t.string :type
    end
  end
end

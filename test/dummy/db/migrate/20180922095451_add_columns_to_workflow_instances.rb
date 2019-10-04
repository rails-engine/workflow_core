# frozen_string_literal: true

class AddColumnsToWorkflowInstances < ActiveRecord::Migration[6.0]
  def change
    change_table :workflow_instances do |t|
      t.string :type

      t.references :creator, polymorphic: true, index: true
    end
  end
end

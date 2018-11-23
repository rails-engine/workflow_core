# frozen_string_literal: true

class AddWorkflowIdToFields < ActiveRecord::Migration[5.2]
  def change
    change_table :fields do |t|
      t.references :workflow, foreign_key: true
    end
  end
end

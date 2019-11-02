# frozen_string_literal: true

class AddStartPlaceIdToWorkflows < ActiveRecord::Migration[6.0]
  def change
    change_table :workflows do |t|
      t.references :start_place, foreign_key: { to_table: "workflow_places" }
    end
  end
end

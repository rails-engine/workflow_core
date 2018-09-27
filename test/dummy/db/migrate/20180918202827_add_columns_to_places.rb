# frozen_string_literal: true

class AddColumnsToPlaces < ActiveRecord::Migration[5.2]
  def change
    change_table :workflow_places do |t|
      t.string :name
      t.string :uid
    end
  end
end

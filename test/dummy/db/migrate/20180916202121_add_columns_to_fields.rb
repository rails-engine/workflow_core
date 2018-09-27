# frozen_string_literal: true

class AddColumnsToFields < ActiveRecord::Migration[5.2]
  def change
    change_table :fields do |t|
      t.string :label, default: ""
      t.string :hint, default: ""
    end
  end
end

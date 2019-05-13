# frozen_string_literal: true

class AddParentIdToGroups < ActiveRecord::Migration[5.2]
  def change
    change_table :groups do |t|
      t.references :parent, foreign_key: { to_table: "groups" }
    end
  end
end

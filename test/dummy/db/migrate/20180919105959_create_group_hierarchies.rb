# frozen_string_literal: true

class CreateGroupHierarchies < ActiveRecord::Migration[5.2]
  def change
    create_table :group_hierarchies, id: false do |t|
      t.integer :ancestor_id, null: false
      t.integer :descendant_id, null: false
      t.integer :generations, null: false
    end

    add_index :group_hierarchies, [:ancestor_id, :descendant_id, :generations],
      unique: true,
      name: "group_anc_desc_idx"

    add_index :group_hierarchies, [:descendant_id],
      name: "group_desc_idx"
  end
end

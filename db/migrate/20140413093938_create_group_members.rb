class CreateGroupMembers < ActiveRecord::Migration
  def change
    create_table :group_members do |t|
      t.integer :knocker_id
      t.integer :group_id
      t.integer :admin, :default => 0
      t.integer :state, :default => 0

      t.timestamps
    end
    add_index :group_members, :knocker_id
    add_index :group_members, :group_id
    add_index :group_members, [:knocker_id, :group_id]
  end
end

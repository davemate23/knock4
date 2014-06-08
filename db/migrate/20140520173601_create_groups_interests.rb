class CreateGroupsInterests < ActiveRecord::Migration
  def change
    create_table :groups_interests do |t|
      t.integer :group_id
      t.integer :interest_id

      t.timestamps
    end
    add_index :groups_interests, :group_id
    add_index :groups_interests, :interest_id
    add_index :groups_interests, [:group_id, :interest_id]
  end
end

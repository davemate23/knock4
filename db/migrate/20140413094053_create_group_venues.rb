class CreateGroupVenues < ActiveRecord::Migration
  def change
    create_table :group_venues do |t|
      t.integer :group_id
      t.integer :venue_id
      t.integer :status, :default => 0

      t.timestamps
    end
    add_index :group_venues, :group_id
    add_index :group_venues, :venue_id
    add_index :group_venues, [:group_id, :venue_id]
  end
end

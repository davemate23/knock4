class CreateGroupEvents < ActiveRecord::Migration
  def change
    create_table :group_events do |t|
      t.integer :group_id
      t.integer :event_id
      t.integer :status, :default => 0
      t.string :description

      t.timestamps
    end
    add_index :group_events, :group_id
    add_index :group_events, :event_id
    add_index :group_events, [:group_id, :event_id]
  end
end

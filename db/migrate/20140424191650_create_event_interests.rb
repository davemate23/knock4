class CreateEventInterests < ActiveRecord::Migration
  def change
    create_table :event_interests do |t|
      t.integer :event_id
      t.integer :interest_id

      t.timestamps
    end
    add_index :event_interests, :interest_id
    add_index :event_interests, :event_id
    add_index :event_interests, [:interest_id, :event_id]
  end
end

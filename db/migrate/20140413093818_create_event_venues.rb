class CreateEventVenues < ActiveRecord::Migration
  def change
    create_table :event_venues do |t|
      t.integer :event_id
      t.integer :venue_id
      t.integer :status
      t.string :description

      t.timestamps
    end
    add_index :event_venues, :event_id
    add_index :event_venues, :venue_id
    add_index :event_venues, [:event_id, :venue_id]
  end
end

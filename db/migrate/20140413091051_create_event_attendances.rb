class CreateEventAttendances < ActiveRecord::Migration
  def change
    create_table :event_attendances do |t|
      t.integer :knocker_id
      t.integer :event_id
      t.integer :admin, :default => 0
      t.integer :state

      t.timestamps
    end
    add_index :event_attendances, :knocker_id
    add_index :event_attendances, :event_id
    add_index :event_attendances, [:knocker_id, :event_id]
  end
end

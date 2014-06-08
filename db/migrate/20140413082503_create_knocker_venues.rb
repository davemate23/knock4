class CreateKnockerVenues < ActiveRecord::Migration
  def change
    create_table :knocker_venues do |t|
      t.integer :knocker_id
      t.integer :venue_id
      t.integer :admin, :default => 0

      t.timestamps
    end
    add_index :knocker_venues, :knocker_id
    add_index :knocker_venues, :venue_id
    add_index :knocker_venues, [:knocker_id, :venue_id], unique: true
  end
end

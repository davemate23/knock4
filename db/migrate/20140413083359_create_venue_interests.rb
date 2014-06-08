class CreateVenueInterests < ActiveRecord::Migration
  def change
    create_table :venue_interests do |t|
      t.integer :venue_id
      t.integer :interest_id
      t.string :description

      t.timestamps
    end
    add_index :venue_interests, :venue_id
    add_index :venue_interests, :interest_id
    add_index :venue_interests, [:venue_id, :interest_id], unique: true
  end
end

class CreateAvailabilities < ActiveRecord::Migration
  def change
    create_table :availabilities do |t|
      t.integer :knocker_id
      t.date :availability

      t.timestamps
    end
    add_index :availabilities, :knocker_id
  	add_index :availabilities, :availability
  end    
end

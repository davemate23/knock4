class CreateFavouriteknockers < ActiveRecord::Migration
  def change
    create_table :favouriteknockers do |t|
    	t.integer :favourited_id
    	t.integer :favourite_id

      t.timestamps
    end
    add_index :favouriteknockers, :favourited_id
    add_index :favouriteknockers, :favourite_id
    add_index :favouriteknockers, [:favourited_id, :favourite_id], unique: true
  end
end

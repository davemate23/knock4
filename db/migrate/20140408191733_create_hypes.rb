class CreateHypes < ActiveRecord::Migration
  def change
    create_table :hypes do |t|
      t.string :content
      t.integer :knocker_id
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
    add_index :hypes, [:knocker_id, :created_at]
  	add_index :hypes, [:latitude, :longitude]
  end
end

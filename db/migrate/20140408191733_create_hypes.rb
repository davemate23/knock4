class CreateHypes < ActiveRecord::Migration
  def change
    create_table :hypes do |t|
      t.string :content
      t.references :author, polymorphic: true
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
    add_index :hypes, [:author_id, :author_type, :created_at]
  	add_index :hypes, [:latitude, :longitude]
  end
end

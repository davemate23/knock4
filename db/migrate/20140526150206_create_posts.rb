class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :knocker_id
      t.string :content
      t.float :latitude
      t.float :longitude
      t.references :postable, polymorphic: true, index: true

      t.timestamps
    end
    add_index :posts, :knocker_id
    add_index :posts, [:latitude, :longitude]
    add_index :posts, [:postable_id, :created_at]
  end
end

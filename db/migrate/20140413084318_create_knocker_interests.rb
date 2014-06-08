class CreateKnockerInterests < ActiveRecord::Migration
  def change
    create_table :knocker_interests do |t|
      t.integer :knocker_id
      t.integer :interest_id
      t.integer :ability
      t.boolean :thirdparty
      t.boolean :teach

      t.timestamps
    end
    add_index :knocker_interests, :knocker_id
    add_index :knocker_interests, :interest_id
    add_index :knocker_interests, [:knocker_id, :interest_id], unique: true
    add_index :knocker_interests, :ability
    add_index :knocker_interests, :thirdparty
    add_index :knocker_interests, :teach
  end
end

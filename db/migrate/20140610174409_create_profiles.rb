class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      
      t.integer :knocker_id
      t.text :about
      t.string :nationality
      t.string :occupation
      t.string :employer
      t.boolean :transport

      t.timestamps
    end
    add_index :profiles, :knocker_id
    add_index :profiles, :nationality
    add_index :profiles, :occupation
    add_index :profiles, :employer
  end
end

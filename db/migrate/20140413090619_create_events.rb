class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :identity
      t.string :name
      t.datetime :start_time
      t.datetime :end_time
      t.text :description
      t.string :website
      t.boolean :private

      t.timestamps
    end
    add_index :events, :name
    add_index :events, :start_time
    add_index :events, :end_time
    add_attachment :events, :avatar
  end
end

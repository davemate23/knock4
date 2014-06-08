class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.string :identity
      t.text :description
      t.string :website
      t.string :phone
      t.boolean :private
      t.boolean :invite

      t.timestamps
    end
    add_index :groups, :name
    add_attachment :groups, :avatar
  end
end

class CreateVenues < ActiveRecord::Migration
  def change
    create_table :venues do |t|
      t.string :name
      t.string :identity
      t.string :address1
      t.string :address2
      t.string :town
      t.string :county
      t.string :postcode
      t.string :country
      t.string :website
      t.string :phone
      t.text :description
      t.float :latitude
      t.float :longitude
      t.boolean :disabled
      t.boolean :parking
      t.boolean :toilets
      t.boolean :food
      t.boolean :drink
      t.boolean :alcohol
      t.boolean :changing
      t.boolean :baby_changing

      t.timestamps
    end
    add_index :venues, [:latitude, :longitude]
    add_index :venues, :name
    add_index :venues, :identity
    add_attachment :venues, :avatar
  end
end

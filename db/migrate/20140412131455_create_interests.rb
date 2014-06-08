class CreateInterests < ActiveRecord::Migration
  def change
    create_table :interests do |t|
      t.string :title
      t.string :wikipedia
      t.text :summary
      t.text :content
      t.string :image_url
      t.string :verb
      t.string :thirdperson
      t.string :parent

      t.timestamps
    end
    add_index :interests, :title
    add_attachment :interests, :avatar
  end
end

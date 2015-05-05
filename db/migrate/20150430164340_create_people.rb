class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :name
      t.string :url
      t.text :description
      t.integer :nb_people
      t.text :adresse
      t.string :contact_name
      t.string :files
      t.string :tags
      t.string :expertises
      t.integer :category

      t.timestamps null: false
    end
  end
end

class CreateTechnologies < ActiveRecord::Migration
  def change
    create_table :technologies do |t|
      t.string :name
      t.string :url
      t.text :description
      t.string :tags
      t.string :files

      t.timestamps null: false
    end
  end
end

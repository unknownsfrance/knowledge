class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :location
      t.string :title
      t.text :description
      t.string :tags
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

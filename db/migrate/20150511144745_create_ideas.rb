class CreateIdeas < ActiveRecord::Migration
  def change
    create_table :ideas do |t|
      t.string :name
      t.text :description
      t.string :files
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

class CreateLangs < ActiveRecord::Migration
  def change
    create_table :langs do |t|
      t.string :name
      # t.references :person, index: true, foreign_key: true
      
      t.timestamps null: false
    end
  end
end

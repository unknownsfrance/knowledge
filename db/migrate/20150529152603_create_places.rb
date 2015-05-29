class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.string :gmaps_address
      t.string :gmaps_id
      t.boolean :is_hq
      t.references :person, index: true, foreign_key: true
      
      t.timestamps null: false
    end
  end
end

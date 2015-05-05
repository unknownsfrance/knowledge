class AddCategoryToDocument < ActiveRecord::Migration
  def change
    change_table :documents do |t|
      t.remove :dtype  
      t.integer :category 
    end
  end
end

class CreateElementsAssocs < ActiveRecord::Migration
  def change
    create_table :elements_assocs do |t|
      t.references :element1, polymorphic: true, index: true
      t.references :element2, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end

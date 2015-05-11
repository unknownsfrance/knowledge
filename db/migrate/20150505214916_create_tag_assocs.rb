class CreateTagAssocs < ActiveRecord::Migration
  def change
    create_table :tag_assocs do |t|
      t.references :tag, index: true, foreign_key: true
      t.references :element, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end

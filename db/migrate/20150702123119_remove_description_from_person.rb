class RemoveDescriptionFromPerson < ActiveRecord::Migration
  def change
    remove_column :people, :description, :text
  end
end

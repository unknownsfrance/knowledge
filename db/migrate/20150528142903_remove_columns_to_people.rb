class RemoveColumnsToPeople < ActiveRecord::Migration
  def change
    remove_column :people, :expertises, :string
    remove_column :people, :adresse, :text
    remove_column :people, :nb_people, :integer
  end
end

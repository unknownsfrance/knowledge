class RemoveTypeFromPeople < ActiveRecord::Migration
  def change
    remove_column :people, :type, :string
    remove_column :documents, :type, :integer
    add_column :documents, :dtype, :integer 
  end
end

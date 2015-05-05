class AddTypeToPeople < ActiveRecord::Migration
  def change
    add_column :people, :type, "enum('enterprise','freelance')" 
  end
end

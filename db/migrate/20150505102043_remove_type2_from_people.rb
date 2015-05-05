class RemoveType2FromPeople < ActiveRecord::Migration
  def change
    remove_column :people, :type, :string
  end
end

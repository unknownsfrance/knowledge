class AddColumnsToPeople < ActiveRecord::Migration
  def change
    add_column :people, :characteristics, :text
    add_column :people, :type, :integer
    add_column :people, :firstname, :string
    add_column :people, :profile, :string
  end
end

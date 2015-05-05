class AddType2ToPeople < ActiveRecord::Migration
  def change
    add_column :people, :type, :string
  end
end

class ChangeTypeForPeople < ActiveRecord::Migration
  def change
    remove_column :people, :type, :integer
    add_column :people, :company_type, :integer
  end
end

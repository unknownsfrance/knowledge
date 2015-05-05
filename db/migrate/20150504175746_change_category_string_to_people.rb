class ChangeCategoryStringToPeople < ActiveRecord::Migration
  def self.up
    change_table :people do |t|
      t.change :category, :integer
    end
  end
end

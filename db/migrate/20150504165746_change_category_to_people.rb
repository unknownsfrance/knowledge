class ChangeCategoryToPeople < ActiveRecord::Migration
  def self.up
    change_table :people do |t|
      t.change :category, :string
    end
  end
end

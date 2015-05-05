class ChangeTypeToPeople < ActiveRecord::Migration
  def self.up
    change_table :people do |t|
      t.change :type, :string
    end
  end
end

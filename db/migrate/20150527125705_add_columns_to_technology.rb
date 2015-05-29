class AddColumnsToTechnology < ActiveRecord::Migration
  def change
    add_column :technologies, :editor, :string
    add_column :technologies, :license, :int
    add_column :technologies, :pricing, :int
    add_column :technologies, :characteristics, :text
  end
end

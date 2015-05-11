class RemoveTagsFromTables < ActiveRecord::Migration
  def change
    remove_column :technologies, :tags, :string
    remove_column :documents, :tags, :string
    remove_column :people, :tags, :string
  end
end

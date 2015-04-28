class AddUserToTechnologies < ActiveRecord::Migration
  def change
    add_reference :technologies, :user, index: true, foreign_key: true
  end
end

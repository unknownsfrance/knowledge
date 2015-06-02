class CreateJoinTable < ActiveRecord::Migration
  def change
    create_join_table :people, :langs do |t|
      # t.index [:person_id, :lang_id]
      # t.index [:lang_id, :person_id]
    end
  end
end

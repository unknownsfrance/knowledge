class Technology < ActiveRecord::Base
  
  searchable do
      text :name, :description, :tags 
      integer :user_id
      
      #text :users do 
      #  users.map { |user| user.first_name }
      #end
      
      #text :user_id do
      #  user_id.map { |user| user.first_name }
      #end
  end 
  
end

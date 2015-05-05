class Technology < ActiveRecord::Base
  
  searchable do
      text :name, :description, :tags 
      integer :user_id
  end 

  def getCat
    return self.class.to_s.capitalize
  end
end

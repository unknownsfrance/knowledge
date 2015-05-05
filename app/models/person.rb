class Person < ActiveRecord::Base
  enum category: [ :enterprise, :freelance ]
  belongs_to :user
  
  searchable do
    text :name, :description, :tags, :contact_name, :expertises 
  end 
  
  
  def getCat
    return self.category.capitalize
  end
end

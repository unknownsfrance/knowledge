class Person < ActiveRecord::Base
  enum category: [ :enterprise, :freelance ]
  belongs_to :user
  
  # Added tag attribute for saving action 
  attr_accessor :tags 
  after_save :save_tags
  has_many :tag_assoc, :as => :element
  
  searchable do
    text :name, :description, :tags, :contact_name, :expertises 
  end 
  
  def getCat
    return self.category.capitalize
  end
  
  protected 
  
  def save_tags
    TagsHelper::updateTagsForModels(self, @tags)
  end
end

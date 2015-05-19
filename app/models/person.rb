class Person < ActiveRecord::Base
  enum category: [ :enterprise, :freelance ]
  belongs_to :user
  
  # Added tag attribute for saving action 
  attr_accessor :tags 
  after_save :save_tags
  has_many :tag_assoc, :as => :element

  # Added tag attribute for saving action 
  has_many :elements_assoc, :as => :element1
  
  searchable do
    text :name, :description, :tags, :contact_name, :expertises 
  end 
  
  def getCat
    return self.category.capitalize
  end
  
  def is_freelance?
    if self.category == 'freelance'
      return true
    end
    return false
  end
  def is_enterprise?
    if self.category == 'enterprise'
      return true
    end
    return false
  end
  
  def save_file upload
    DocumentsHelper.upload_file(upload, self)
  end
  
  protected 
  
  def save_tags
    TagsHelper::updateTagsForModels(self, @tags)
  end
end

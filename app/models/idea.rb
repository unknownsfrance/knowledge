class Idea < ActiveRecord::Base
  belongs_to :user
  
  # Added tag attribute for saving action 
  attr_accessor :tags 
  after_save :save_tags
  has_many :tag_assoc, :as => :element
  
  # Added tag attribute for saving action 
  has_many :elements_assoc, :as => :element1
  
  # SolR entity 
  searchable do
    text :name, :description, :tags 
    integer :user_id
  end 
  
  def getCat
    return self.class.to_s.capitalize
  end
  
  def save_file upload
    DocumentsHelper.upload_file(upload, self)
  end
  
  protected
  
  def save_tags
    TagsHelper::updateTagsForModels(self, @tags)
  end
end

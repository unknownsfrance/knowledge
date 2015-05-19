class Document < ActiveRecord::Base
  enum category: [ :article, :file ]
  belongs_to :user

  # Added tag attribute for saving action 
  attr_accessor :tags 
  after_save :save_tags
  has_many :tag_assoc, :as => :element

  # Added tag attribute for saving action 
  has_many :elements_assoc, :as => :element1
  
  # SolR entity 
  searchable do
    text :title, :description, :tags 
    integer :user_id
  end 
  
  def getCat
    return self.category.capitalize
  end
  
  def is_article?
    if self.category == 'article'
      return true
    end
    return false
  end
  def is_file?
    if self.category == 'file'
      return true
    end
    return false
  end

  def save_file upload
    drive_id = DocumentsHelper.upload_file(upload, self, false)
    if drive_id
      self.location = drive_id
      self.save
    end
  end
  
  protected
  
  def save_tags
    TagsHelper::updateTagsForModels(self, @tags)
  end
end

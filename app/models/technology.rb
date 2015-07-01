class Technology < ActiveRecord::Base
  belongs_to :user
  enum license: [ :proprietary, :open_source, :free ]
  enum pricing: [ :full_free, :paid, :free_and_paid, :trial_then_paid, :other ]
  
  # Added tag attribute for saving action 
  attr_accessor :tags 
  after_save :save_tags 
  has_many :tag_assoc, :as => :element

  # Added tag attribute for saving action 
  has_many :elements_assoc, :as => :element1
  
  searchable do
    text :name, :description, :editor, :license, :pricing, :characteristics, :tags 
    integer :user_id
  end 
  
  def getCat
    return self.class.to_s.capitalize
  end

  def getTitle
    return self.name
  end

  def save_file upload
    DocumentsHelper.upload_file(upload, self)
  end
  
  protected
  
  def save_tags
    TagsHelper::updateTagsForModels(self, @tags)
  end
  
  def assign_user
    self.user_id = current_user.id
  end
end

class Technology < ActiveRecord::Base
  belongs_to :user
  
  # Added tag attribute for saving action 
  attr_accessor :tags 
  after_save :save_tags 
  has_many :tag_assoc, :as => :element
  
  #after_create :assign_user
  
  searchable do
    text :name, :description, :tags 
    integer :user_id
  end 

  def getCat
    return self.class.to_s.capitalize
  end
  
  protected
  
  def save_tags
    TagsHelper::updateTagsForModels(self, @tags)
  end
  
  def assign_user
    self.user_id = current_user.id
  end
end

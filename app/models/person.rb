class Person < ActiveRecord::Base
  enum category: [ :enterprise, :person ]
  enum company_type: [ :start_up, :agency ]
  belongs_to :user
  
  # Added tag attribute for saving action 
  attr_accessor :tags 
  after_save :save_tags
  has_many :tag_assoc, :as => :element

  attr_accessor :hq_name, :hq_id
  after_save :save_hq
  
  attr_accessor :localizations
  after_save :save_localizations  
  
  # Added tag attribute for saving action 
  has_many :elements_assoc, :as => :element1
  
  searchable do
    text :name, :description, :tags, :contact_name, :characteristics 
  end 
  
  def getCat
    return self.category.capitalize
  end
  
  def is_person?
    if self.category == 'person'
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

  def save_hq
    if not @hq_name.empty? and not @hq_id.empty?
      Place.where(:person => self).destroy_all
      Place.create(
        :gmaps_address => @hq_name, 
        :gmaps_id => @hq_id, 
        :is_hq => 1, 
        :person => self
      )
    end
  end
  
  def save_localizations
    #loc = JSON.stringify(eval("(" + @localizations + ")")) 
    #@localizations.each do |k,o|
    #  puts k, o, '-----------------'
    #end
    #abort()
  end
  
  def save_tags
    TagsHelper::updateTagsForModels(self, @tags)
  end
end

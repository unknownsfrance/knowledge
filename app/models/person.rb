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
  has_many :place
  
  attr_accessor :languages
  after_save :save_langs
  has_and_belongs_to_many :langs
  
  # Added tag attribute for saving action 
  has_many :elements_assoc, :as => :element1
  
  searchable do
    text :name, :firstname, :description, :characteristics, :company_type, :contact_name, :tags
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
      Place.where(:person => self, :is_hq => 1).destroy_all
      Place.create(
        :gmaps_address => @hq_name, 
        :gmaps_id => @hq_id, 
        :is_hq => 1, 
        :person => self
      )
    end
  end
  
  def save_localizations
    items = JSON.load @localizations
    Place.where( :person => self, :is_hq => 0 ).destroy_all
    if items
      items.each do |i, item|
        Place.create(
          :gmaps_address => item['name'], 
          :gmaps_id => item['id'], 
          :is_hq => 0, 
          :person => self
        )
      end
    end 
  end

  def save_langs
    self.langs.destroy_all
    if (@languages)
      langList = @languages.split(',').map { |l| l.squish! } 
      Lang.where(:name => langList).each do |l|
        puts l.name
        self.langs << l
      end 
    end 
  end
  
  def save_tags
    TagsHelper::updateTagsForModels(self, @tags)
  end
end

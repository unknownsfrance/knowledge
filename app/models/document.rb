class Document < ActiveRecord::Base
  enum category: [ :article, :file ]
  belongs_to :user
  
  def getCat
    return self.category.capitalize
  end
end

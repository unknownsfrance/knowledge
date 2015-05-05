class Document < ActiveRecord::Base
  enum category: [ :article, :file ]
  belongs_to :user
end

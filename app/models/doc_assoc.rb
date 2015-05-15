class DocAssoc < ActiveRecord::Base
  belongs_to :document
  belongs_to :element, polymorphic: true
end

class TagAssoc < ActiveRecord::Base
  belongs_to :tag
  belongs_to :element, polymorphic: true
end

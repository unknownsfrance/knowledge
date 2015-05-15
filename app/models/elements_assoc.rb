class ElementsAssoc < ActiveRecord::Base
  belongs_to :element1, polymorphic: true
  belongs_to :element2, polymorphic: true
end

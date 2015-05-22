module TagsHelper
  def self.updateTagsForModels model, tags
    existing_tags = Hash.new
    
    # Create missing tags 
    if (tags)
      tagList = tags.split(',').map { |t| t.squish! } 
      Tag.where(:tag => tagList).each do |t|
        existing_tags[t.id] = t.tag 
      end 
    end 
    
    if (tagList)
      tagList.each do |tag|
        if existing_tags.has_value?(tag) === false 
          new_tag = Tag.create(tag: tag)
          existing_tags[new_tag.id] = new_tag.tag 
        end
      end
    end 
    
    # Reassoc all tags 
    TagAssoc.where(:element => model).destroy_all
    existing_tags.each do |tag_id, tag_val|
      TagAssoc.create(:element => model, :tag_id => tag_id)
    end 
    
  end
end

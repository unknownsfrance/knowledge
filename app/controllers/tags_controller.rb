class TagsController < ApplicationController
  # GET /tags
  # GET /tags.json
  def index
    @term = params[:term] 
    @tags = Tag.where('tag LIKE :theTag', { :theTag => "%#{@term}%" })
  end
end

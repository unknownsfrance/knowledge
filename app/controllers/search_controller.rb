class SearchController < ApplicationController
  before_action :authenticate_user! 
  
  def index 
    
  end
  
  def results
    @query = params[:q] 
    @users = UsersHelper.all_as_array
    
    @search = Sunspot.search Technology, Person, Idea do |query| 
      query.keywords @query
    end
  end
  
end

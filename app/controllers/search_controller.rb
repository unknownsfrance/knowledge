class SearchController < ApplicationController
  before_action :authenticate_user! 
  
  def index 
    
  end
  
  def results
    @query = params[:q] 
    @users = UsersHelper.all_as_array
    
    @search = Sunspot.search Technology, Person do |query| 
      query.keywords @query
      #query.with(:age).greater_than 20
      #query.with(:age).less_than 25
      #query.paginate(:page => params[:page], :per_page => 30)
    end
    
  end
  
end

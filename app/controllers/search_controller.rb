class SearchController < ApplicationController
  before_action :authenticate_user! 
  
  def index 
    
  end
  
  def results
    @query = params[:q] 
    @users = UsersHelper.all_as_array
    
    @search = Technology.search do
      fulltext params[:q]
    end
    
  end
  
end

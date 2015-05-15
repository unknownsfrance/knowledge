require 'google/api_client'

class HomeController < ApplicationController
  layout "home"
  
  def index
    if user_signed_in?
      redirect_to :controller => 'technologies', :action => 'new'
    end
  end
    
  def test_gdrive
    
  end
  
  def upload_file
    
  end
end

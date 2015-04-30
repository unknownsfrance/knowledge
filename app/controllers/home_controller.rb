class HomeController < ApplicationController
  layout "home"
  
  def index
    if user_signed_in?
      redirect_to :controller => 'technologies', :action => 'new'
    end
  end
end

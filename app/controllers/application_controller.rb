class ApplicationController < ActionController::Base
  before_filter :configure_charsets
  
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  def configure_charsets
    response.headers["Content-Type"] = "text/html; charset=utf-8"
    suppress(ActiveRecord::StatementInvalid) do 
      ActiveRecord::Base.connection.execute 'SET NAMES UTF8'
    end
  end
end

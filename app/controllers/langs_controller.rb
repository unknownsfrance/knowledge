class LangsController < ApplicationController
  # GET /tags
  # GET /tags.json
  def index
    @term = params[:term] 
    @langs = Lang.where('name LIKE :theLang', { :theLang => "%#{@term}%" })
  end
end

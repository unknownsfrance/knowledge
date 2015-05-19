class SearchController < ApplicationController
  before_action :authenticate_user! 
  
  def index 
    if params[:ajax]
      render layout: 'ajax'
    end
  end
  
  def results
    self.do_search
  end
  
  # Module displayed in the association popin
  def relationmodule
    @itemtype = params[:itemtype]
    @itemid = params[:itemid]
    
    # Get all current relations
    relatedItems = ElementsAssoc.where('(element1_type = :elm1type AND element1_id = :elm1id) OR (element2_type = :elm1type AND element2_id = :elm1id)', { :elm1type => @itemtype, :elm1id => @itemid })
    @associated = Array.new
    relatedItems.each do |item|
      if item.element1.class.to_s == @itemtype and item.element1[:id].to_s == @itemid
        @associated.push(item.element2.getCat + '_' + item.element2[:id].to_s)
      elsif item.element2.class.to_s == @itemtype and item.element2[:id].to_s == @itemid
        @associated.push(item.element1.getCat + '_' + item.element1[:id].to_s)
      end
    end
    
    self.do_search
    render layout: false
  end

  def do_link_elements 
    type = params[:type]
    element1Type = params[:elm1Type]
    element1Id = params[:elm1Id]
    element2Type = params[:elm2Type]
    element2Id = params[:elm2Id]
    
    @results = ElementsAssoc.where('(element1_type = :elm1type AND element1_id = :elm1id AND element2_type = :elm2type AND element2_id = :elm2id) OR (element2_type = :elm1type AND element2_id = :elm1id AND element1_type = :elm2type AND element1_id = :elm2id)', { :elm1type => element1Type, :elm1id => element1Id, :elm2type => element2Type, :elm2id => element2Id })
    
    if type == 'link' and @results.count == 0
      # Add it 
      ElementsAssoc.create(:element1_type => element1Type, :element1_id => element1Id, :element2_type => element2Type, :element2_id => element2Id)
    elsif type == 'unlink' and @results.count > 0
      # Remove it 
      @results.destroy_all
    end
    render :text => 'ok', :layout => false
  end
  
  protected 
  
  def do_search
    @query = params[:q] 
    @users = UsersHelper.all_as_array
    
    @search = Sunspot.search Technology, Person, Idea, Document do |query| 
      query.keywords @query
    end
  end
end

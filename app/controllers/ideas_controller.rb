class IdeasController < ApplicationController
  before_action :authenticate_user! 
  before_action :set_idea, only: [:show, :edit, :update, :destroy]
  before_action :set_associated_elements, only: [:show, :edit]

  # GET /ideas
  # GET /ideas.json
  def index
    @ideas = Idea.all
  end

  # GET /ideas/1
  # GET /ideas/1.json
  def show
    if params[:ajax]
      render layout: 'ajax'
    end
  end

  # GET /ideas/new
  def new
    @idea = Idea.new
  end
  
  # GET /ideas/1/edit
  def edit
  end
  
  # POST /ideas
  # POST /ideas.json
  def create
    @idea = Idea.new(idea_params)
    @idea.user_id = current_user.id
    
    respond_to do |format|
      if @idea.save
        @idea.save_file(params[:upload]) if params[:upload]
        format.html { redirect_to @idea, notice: 'Idea was successfully created.' }
        format.json { render :show, status: :created, location: @idea }
      else
        format.html { render :new }
        format.json { render json: @idea.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ideas/1
  # PATCH/PUT /ideas/1.json
  def update
    respond_to do |format|
      if @idea.update(idea_params)
        @idea.save_file(params[:upload]) if params[:upload]
        format.html { redirect_to @idea, notice: 'Idea was successfully updated.' }
        format.json { render :show, status: :ok, location: @idea }
      else
        format.html { render :edit }
        format.json { render json: @idea.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ideas/1
  # DELETE /ideas/1.json
  def destroy
    @idea.destroy
    respond_to do |format|
      format.html { redirect_to new_idea_path, notice: 'Idea was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_idea
      @idea = Idea.find(params[:id])
    end
    
    def set_associated_elements
      @associatedElements = ElementsAssoc.where('(element1_type = :elm1type AND element1_id = :elm1id) OR (element2_type = :elm1type AND element2_id = :elm1id)', { :elm1type => @idea.class.to_s, :elm1id => @idea[:id].to_s })
    end
  
    # Never trust parameters from the scary internet, only allow the white list through.
    def idea_params
      params.require(:idea).permit(:name, :description, :tags, :file)
    end
end

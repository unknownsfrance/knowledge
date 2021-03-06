class TechnologiesController < ApplicationController
  before_action :authenticate_user! 
  before_action :set_technology, only: [:show, :edit, :update, :destroy]
  before_action :set_associated_elements, only: [:show, :edit]
  
  # GET /technologies
  # GET /technologies.json
  def index
    @technologies = Technology.all
  end

  # GET /technologies/1
  # GET /technologies/1.json
  def show
    if params[:ajax]
      render layout: 'ajax'
    end
  end

  # GET /technologies/new
  def new
    @technology = Technology.new
  end

  # GET /technologies/1/edit
  def edit
  end
  
  # POST /technologies
  # POST /technologies.json
  def create
    @technology = Technology.new(technology_params)
    @technology.user_id = current_user.id

    respond_to do |format|
      if @technology.save
        @technology.save_file(params[:upload]) if params[:upload]
        flash[:success] = 'Technology was successfully created.'
        format.html { redirect_to @technology }
        format.json { render :show, status: :created, location: @technology }
      else
        flash[:danger] = 'There was a problem creating the Technology.'
        format.html { render :new }
        format.json { render json: @technology.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /technologies/1
  # PATCH/PUT /technologies/1.json
  def update 
    respond_to do |format|
      if @technology.update(technology_params)
        @technology.save_file(params[:upload]) if params[:upload]
        flash[:success] = 'Technology was successfully updated.'
        format.html { redirect_to @technology }
        format.json { render :show, status: :ok, location: @technology }
      else
        flash[:danger] = 'There was a problem updating the Technology.'
        format.html { render :edit }
        format.json { render json: @technology.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /technologies/1
  # DELETE /technologies/1.json
  def destroy
    @technology.destroy
    respond_to do |format|
      flash[:success] = 'Technology was successfully destroyed.'
      format.html { redirect_to new_technology_path }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_technology
      @technology = Technology.find(params[:id])
    end
    
    def set_associated_elements
      @associatedElements = ElementsAssoc.where('(element1_type = :elm1type AND element1_id = :elm1id) OR (element2_type = :elm1type AND element2_id = :elm1id)', { :elm1type => @technology.class.to_s, :elm1id => @technology[:id].to_s })
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def technology_params
      params.require(:technology).permit(:name, :url, :editor, :license, :pricing, :description, :characteristics, :tags, :files)
    end
end

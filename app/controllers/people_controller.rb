class PeopleController < ApplicationController
  before_action :authenticate_user! 
  before_action :set_person, only: [:show, :edit, :update, :destroy]
  before_action :set_associated_elements, only: [:show, :edit]

  # GET /people
  # GET /people.json
  def index
    @people = Person.all
  end

  # GET /people/1
  # GET /people/1.json
  def show
    if params[:ajax]
      render layout: 'ajax'
    end
  end

  # GET /people/new
  def new
    @person = Person.new
    if params[:type] == 'enterprise'
      @person.category = :enterprise
    elsif params[:type] == 'person'
      @person.category = :person
    else 
      raise ArgumentError, 'Person type not specified'
    end
  end

  # GET /people/1/edit
  def edit
  end

  # POST /people
  # POST /people.json
  def create
    @person = Person.new(person_params)
    @person.user_id = current_user.id
    
    respond_to do |format|
      if @person.save
        @person.save_file(params[:upload]) if params[:upload]
        format.html { redirect_to @person, notice: 'Person was successfully created.' }
        format.json { render :show, status: :created, location: @person }
      else
        format.html { render :new }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /people/1
  # PATCH/PUT /people/1.json
  def update
    respond_to do |format|
      if @person.update(person_params)
        @person.save_file(params[:upload]) if params[:upload]
        format.html { redirect_to @person, notice: 'Person was successfully updated.' }
        format.json { render :show, status: :ok, location: @person }
      else
        format.html { render :edit }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /people/1
  # DELETE /people/1.json
  def destroy
    cat = @person.category
    @person.destroy
    respond_to do |format|
      format.html {
        msg = 'Person was successfully destroyed.'
        if cat == 'enterprise'
          redirect_to enterprise_new_path, notice: msg
        else 
          redirect_to person_new_path, notice: msg
        end
      }
      format.json { head :no_content }
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_person
      @person = Person.find(params[:id])
    end
    
    def set_associated_elements
      @associatedElements = ElementsAssoc.where('(element1_type = :elm1type AND element1_id = :elm1id) OR (element2_type = :elm1type AND element2_id = :elm1id)', { :elm1type => @person.class.to_s, :elm1id => @person[:id].to_s })
      
      @hq = {}
      @localizations = {}
      @person.place.each do |p|
        if p.is_hq
          @hq[p.gmaps_id] = p.gmaps_address
        else 
          @localizations[p.gmaps_id] = p.gmaps_address
        end
      end
    end
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def person_params
      params[:person][:localizations] = params[:person][:localizations].to_json
      params.require(:person).permit(:name, :firstname, :profile, :url, :company_type, :characteristics, :description, :hq_name, :hq_id, :localizations, :contact_name, :files, :tags, :languages, :category)
    end
end

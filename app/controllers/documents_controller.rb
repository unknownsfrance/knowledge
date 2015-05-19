class DocumentsController < ApplicationController
  before_action :set_document, only: [:show, :edit, :update, :destroy]
  before_action :set_associated_elements, only: [:show, :edit]
  
  # GET /documents
  # GET /documents.json
  def index
    @documents = Document.all
  end
  
  # GET /documents/1
  # GET /documents/1.json
  def show
    if params[:ajax]
      render layout: 'ajax'
    end
  end
  
  # GET /documents/new
  def new
    @document = Document.new
    if params[:type] == 'article'
      @document.category = :article
    elsif params[:type] == 'file'
      @document.category = :file
    else 
      raise ArgumentError, 'Document type not specified'
    end
  end
  
  # GET /documents/1/edit
  def edit
  end

  # POST /documents
  # POST /documents.json
  def create
    @document = Document.new(document_params)
    @document.user_id = current_user.id
    
    respond_to do |format|
      if @document.save
        format.html { redirect_to @document, notice: 'Document was successfully created.' }
        format.json { render :show, status: :created, location: @document }
      else
        format.html { render :new }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /documents/1
  # PATCH/PUT /documents/1.json
  def update
    respond_to do |format|
      if @document.update(document_params)
        @document.save_file(params[:upload]) if params[:upload]
        format.html { redirect_to @document, notice: 'Document was successfully updated.' }
        format.json { render :show, status: :ok, location: @document }
      else
        format.html { render :edit }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /documents/1
  # DELETE /documents/1.json
  def destroy
    @document.destroy
    respond_to do |format|
      format.html { redirect_to documents_url, notice: 'Document was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_document
      @document = Document.find(params[:id])
    end
    
    def set_associated_elements
      @associatedElements = ElementsAssoc.where('(element1_type = :elm1type AND element1_id = :elm1id) OR (element2_type = :elm1type AND element2_id = :elm1id)', { :elm1type => @document.class.to_s, :elm1id => @document[:id].to_s })
    end
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def document_params
      params.require(:document).permit(:location, :title, :description, :tags, :category)
    end
end

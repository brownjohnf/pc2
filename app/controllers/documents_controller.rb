class DocumentsController < ApplicationController
  
  load_and_authorize_resource

  # GET /documents
  # GET /documents.json
  def index
    @documents = Document.unscoped.order('updated_at DESC').paginate(:page => params[:page], :per_page => 20)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @documents }
    end
  end
  
  # GET /documents/table
  def table
    @documents = Document.all

    respond_to do |format|
      format.html { render :layout => 'layouts/application-fluid' } # index.html.erb
      format.json { render json: @documents }
    end
  end
  
  # GET /documents/search?q
  def search
    if params[:q]
      @documents = Document.unscoped.order('updated_at DESC').search(params[:q]).paginate(:page => params[:page], :per_page => 20)
      @count = @documents.count
      
      render 'index'
    else
      redirect_to documents_path
    end
  end

  # GET /documents/1
  # GET /documents/1.json
  def show
    @document = Document.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @document }
    end
  end

  # GET /documents/new
  # GET /documents/new.json
  def new
    @document = Document.new
    @document.roles << Role.find_by_name('Public')

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @document }
    end
  end

  # GET /documents/1/edit
  def edit
    @document = Document.find(params[:id])
  end

  # POST /documents
  # POST /documents.json
  def create
    @document = Document.new(params[:document])
    @document.user_id = current_user.id

    respond_to do |format|
      if @document.save
        format.html { redirect_to @document, notice: 'Document was successfully created.' }
        format.json { render json: @document, status: :created, location: @document }
      else
        format.html { render action: "new" }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /documents/1
  # PUT /documents/1.json
  def update
    @document = Document.find(params[:id])

    respond_to do |format|
      if @document.update_attributes(params[:document])
        format.html { redirect_to @document, notice: 'Document was successfully updated.' }
        format.json { respond_with_bip @document }
      else
        format.html { render action: "edit" }
        format.json { respond_with_bip @document }
      end
    end
  end

  # DELETE /documents/1
  # DELETE /documents/1.json
  def destroy
    @document = Document.find(params[:id])
    @document.destroy

    respond_to do |format|
      format.html { redirect_to documents_url }
      format.json { head :ok }
    end
  end
 
  # GET /documents/1/download
  def download
    @document = Document.find(params[:id])
    # send_file @document.file.to_file, :type => @document.file_content_type
    send_file Paperclip.io_adapters.for(@document.file).path, :type => @document.file_content_type
  end
 
  # GET /documents/1/download_source
  def download_source
    @document = Document.find(params[:id])
    send_file Paperclip.io_adapters.for(@document.source).path, :type => @document.source_content_type
  end
end

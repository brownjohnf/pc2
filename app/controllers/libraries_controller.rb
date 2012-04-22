class LibrariesController < ApplicationController
  
  load_and_authorize_resource
  
  # GET /libraries
  # GET /libraries.json
  def index
    @libraries = @libraries.order('name ASC').paginate(:page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @libraries }
    end
  end

  def search
    if params[:q]
      @libraries = Library.search(params[:q]).paginate(:page => params[:page], :per_page => 20)
      render 'index'
    else
      redirect_to libraries_path
    end
  end

  # GET /libraries/1
  # GET /libraries/1.json
  def show
    @library = Library.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @library }
      format.svg { render :qrcode => request.url }
    end
  end

  # GET /libraries/new
  # GET /libraries/new.json
  def new
    @library = Library.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @library }
    end
  end

  # GET /libraries/1/edit
  def edit
    @library = Library.find(params[:id])
  end

  # POST /libraries
  # POST /libraries.json
  def create
    @library = Library.new(params[:library])

    respond_to do |format|
      if @library.save
        format.html { redirect_to @library, notice: 'Library was successfully created.' }
        format.json { render json: @library, status: :created, location: @library }
      else
        format.html { render action: "new" }
        format.json { render json: @library.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /libraries/1
  # PUT /libraries/1.json
  def update
    @library = Library.find(params[:id])

    respond_to do |format|
      if @library.update_attributes(params[:library])
        format.html { redirect_to @library, notice: 'Library was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @library.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /libraries/1
  # DELETE /libraries/1.json
  def destroy
    @library = Library.find(params[:id])
    @library.destroy

    respond_to do |format|
      format.html { redirect_to libraries_url }
      format.json { head :ok }
    end
  end
  
  # GET /libraries/1/download
  def download
    @library = Library.find(params[:id])
    
    if @library.bundle
      send_file "public/system/#{Rails.env}/#{@library.file_name}"
      File.delete("public/system/#{Rails.env}/#{@library.file_name}")
    else
      redirect_to @library, notice: 'There was an error zipping your file. Please try again later.'
    end
  end
  
  # GET /libraries/1/podcast
  def podcast
    @library = Library.find(params[:id])
    @title = @library.name
    @link = podcast_library_url(@library)
    @language = 'en-us'
    @copyright = '2010 - 2012, Peace Corps ' + @library.country
    @subtitle = "Peace Corps #{@library.country} | #{@library.name}"
    @author = "Peace Corps #{@library.country}"
    @description = @library.description
    @itunes_name = 'Peace Corps Senegal'
    @itunes_email = 'admin@pcsenegal.org'

    # the mp3 files
    @mp3s = @library.mp3s
      
    if @mp3s.empty?
      redirect_to @library, notice: 'There is currently no podcast associated with this library.'
    else
      respond_to do |format|
        format.xml { render :layout => false }
      end
    end
  end
  
end

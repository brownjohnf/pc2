class PhotosController < ApplicationController
  
  load_and_authorize_resource

  # GET /photos
  # GET /photos.json
  def index
    @photos = Photo.paginate(:page => params[:page], :per_page => 50)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @photos }
    end
  end
  
  def search
    if params[:q]
      @photos = Photo.unscoped.order('updated_at DESC').search(params[:q]).paginate(:page => params[:page], :per_page => 50)
      @count = @photos.count 
      render 'index'
    else
      redirect_to photos_path
    end
  end

  # GET /photos/1
  # GET /photos/1.json
  def show
    @photo = Photo.find(params[:id])
    @next = Photo.unscoped.order('photos.id ASC').where("id > #{@photo.id}").limit(1).first
    @prev = Photo.unscoped.order('photos.id DESC').where("id < #{@photo.id}").limit(1).first

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @photo }
    end
  end
  
  def embed
    @photo = Photo.find(params[:id])
    redirect_to @photo.photo.url(:small)
  end

  # GET /photos/new
  # GET /photos/new.json
  def new
    @photo = current_user.photos.build(:user_id => current_user.id)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @photo }
    end
  end

  # GET /photos/1/edit
  def edit
    @photo = Photo.find(params[:id])
  end

  # POST /photos
  # POST /photos.json
  def create
    @photo = current_user.photos.build(params[:photo])
    @photo.imageable = current_user

    respond_to do |format|
      if @photo.save
        format.html { redirect_to @photo, notice: 'Photo was successfully created.' }
        format.json { render json: @photo, status: :created, location: @photo }
      else
        format.html { render action: "new" }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /photos/1
  # PUT /photos/1.json
  def update
    @photo = Photo.find(params[:id])

    respond_to do |format|
      if @photo.update_attributes(params[:photo])
        format.html { redirect_to @photo, notice: 'Photo was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /photos/1
  # DELETE /photos/1.json
  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy

    respond_to do |format|
      format.html { redirect_to photos_url }
      format.json { head :ok }
    end
  end

end

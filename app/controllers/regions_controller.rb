class RegionsController < ApplicationController

  before_filter :authenticate, :except => [:index, :show] #sessions helper
  
  # GET /regions
  # GET /regions.json
  def index
    @title = 'Listing Regions'
    @context_menu = {'new region' => new_region_path}
    @regions = Region.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @regions }
    end
  end

  # GET /regions/1
  # GET /regions/1.json
  def show
    @region = Region.find(params[:id])
    @title = @region.name
    @context_menu = {'regions' => regions_path, 'new' => new_region_path, 'edit' => edit_region_path}

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @region }
    end
  end

  # GET /regions/new
  # GET /regions/new.json
  def new
    @region = Region.new
    @title = 'New Region'
    @context_menu = {'cancel' => regions_path}

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @region }
    end
  end

  # GET /regions/1/edit
  def edit
    @region = Region.find(params[:id])
    @title = @region.name
    @context_menu = {'regions' => regions_path, 'new' => new_region_path, 'show' => region_path}
  end

  # POST /regions
  # POST /regions.json
  def create
    @region = Region.new(params[:region])

    respond_to do |format|
      if @region.save
        format.html { redirect_to @region, notice: 'Region was successfully created.' }
        format.json { render json: @region, status: :created, location: @region }
      else
        format.html { render action: "new" }
        format.json { render json: @region.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /regions/1
  # PUT /regions/1.json
  def update
    @region = Region.find(params[:id])

    respond_to do |format|
      if @region.update_attributes(params[:region])
        format.html { redirect_to @region, notice: 'Region was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @region.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /regions/1
  # DELETE /regions/1.json
  def destroy
    @region = Region.find(params[:id])
    @region.destroy

    respond_to do |format|
      format.html { redirect_to regions_url }
      format.json { head :ok }
    end
  end
end

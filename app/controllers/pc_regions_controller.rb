class PcRegionsController < ApplicationController
  
  load_and_authorize_resource
  
  # GET /pc_regions
  # GET /pc_regions.json
  def index
    @pc_regions = PcRegion.all
    @title = 'PC Regions'
    @context_menu = {'new' => new_pc_region_path}

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pc_regions }
    end
  end

  # GET /pc_regions/1
  # GET /pc_regions/1.json
  def show
    @pc_region = PcRegion.find(params[:id])
    @title = @pc_region.name
    @context_menu = {'back' => pc_regions_path, 'new' => new_pc_region_path, 'edit' => edit_pc_region_path}

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @pcregion }
    end
  end

  # GET /pc_regions/new
  # GET /pc_regions/new.json
  def new
    @pc_region = PcRegion.new
    @title = 'New PC Region'
    @context_menu = {'cancel' => pc_regions_path}

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @pc_region }
    end
  end

  # GET /pc_regions/1/edit
  def edit
    @pc_region = PcRegion.find(params[:id])
    @title = @pc_region.name
    @context_menu = {'back' => pc_regions_path, 'cancel' => pc_region_path, 'new' => new_pc_region_path}
  end

  # POST /pc_regions
  # POST /pc_regions.json
  def create
    @pc_region = PcRegion.new(params[:pc_region])

    respond_to do |format|
      if @pc_region.save
        format.html { redirect_to @pc_region, notice: 'Pc_region was successfully created.' }
        format.json { render json: @pc_region, status: :created, location: @pc_region }
      else
        format.html { render action: "new" }
        format.json { render json: @pc_region.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /pc_regions/1
  # PUT /pc_regions/1.json
  def update
    @pc_region = PcRegion.find(params[:id])

    respond_to do |format|
      if @pc_region.update_attributes(params[:pc_region])
        format.html { redirect_to @pc_region, notice: 'Pc_region was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @pc_region.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pc_regions/1
  # DELETE /pc_regions/1.json
  def destroy
    @pc_region = PcRegion.find(params[:id])
    @pc_region.destroy

    respond_to do |format|
      format.html { redirect_to pc_regions_url }
      format.json { head :ok }
    end
  end
end

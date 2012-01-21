class PcregionsController < ApplicationController

  before_filter :authenticate, :except => [:index, :show] #sessions helper
  
  # GET /pcregions
  # GET /pcregions.json
  def index
    @pcregions = Pcregion.all
    @title = 'PC Regions'
    @context_menu = {'new' => new_pcregion_path}

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pcregions }
    end
  end

  # GET /pcregions/1
  # GET /pcregions/1.json
  def show
    @pcregion = Pcregion.find(params[:id])
    @title = @pcregion.name
    @context_menu = {'back' => pcregions_path, 'new' => new_pcregion_path, 'edit' => edit_pcregion_path}

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @pcregion }
    end
  end

  # GET /pcregions/new
  # GET /pcregions/new.json
  def new
    @pcregion = Pcregion.new
    @title = 'New PC Region'
    @context_menu = {'cancel' => pcregions_path}

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @pcregion }
    end
  end

  # GET /pcregions/1/edit
  def edit
    @pcregion = Pcregion.find(params[:id])
    @title = @pcregion.name
    @context_menu = {'back' => pcregions_path, 'cancel' => pcregion_path, 'new' => new_pcregion_path}
  end

  # POST /pcregions
  # POST /pcregions.json
  def create
    @pcregion = Pcregion.new(params[:pcregion])

    respond_to do |format|
      if @pcregion.save
        format.html { redirect_to @pcregion, notice: 'Pcregion was successfully created.' }
        format.json { render json: @pcregion, status: :created, location: @pcregion }
      else
        format.html { render action: "new" }
        format.json { render json: @pcregion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /pcregions/1
  # PUT /pcregions/1.json
  def update
    @pcregion = Pcregion.find(params[:id])

    respond_to do |format|
      if @pcregion.update_attributes(params[:pcregion])
        format.html { redirect_to @pcregion, notice: 'Pcregion was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @pcregion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pcregions/1
  # DELETE /pcregions/1.json
  def destroy
    @pcregion = Pcregion.find(params[:id])
    @pcregion.destroy

    respond_to do |format|
      format.html { redirect_to pcregions_url }
      format.json { head :ok }
    end
  end
end

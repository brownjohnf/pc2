class RegiontypesController < ApplicationController

  before_filter :authenticate_admin, :except => [ :index, :show ] #sessions helper

  # GET /regiontypes
  # GET /regiontypes.json
  def index
    @regiontypes = Regiontype.all
    @title = 'Listing Region Types'
    @context_menu = {'new' => new_regiontype_path}

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @regiontypes }
    end
  end

  # GET /regiontypes/1
  # GET /regiontypes/1.json
  def show
    @regiontype = Regiontype.find(params[:id])
    @title = @regiontype.name
    @context_menu = {'back' => regiontypes_path, 'new' => new_regiontype_path, 'edit' => edit_regiontype_path}

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @regiontype }
    end
  end

  # GET /regiontypes/new
  # GET /regiontypes/new.json
  def new
    @regiontype = Regiontype.new
    @title = 'New Region Type'
    @context_menu = {'cancel' => regiontypes_path}

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @regiontype }
    end
  end

  # GET /regiontypes/1/edit
  def edit
    @regiontype = Regiontype.find(params[:id])
    @title = @regiontype.name
    @context_menu = {'back' => regiontypes_path, 'cancel' => regiontype_path, 'new' => new_regiontype_path}
  end

  # POST /regiontypes
  # POST /regiontypes.json
  def create
    @regiontype = Regiontype.new(params[:regiontype])

    respond_to do |format|
      if @regiontype.save
        format.html { redirect_to @regiontype, notice: 'Regiontype was successfully created.' }
        format.json { render json: @regiontype, status: :created, location: @regiontype }
      else
        format.html { render action: "new" }
        format.json { render json: @regiontype.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /regiontypes/1
  # PUT /regiontypes/1.json
  def update
    @regiontype = Regiontype.find(params[:id])

    respond_to do |format|
      if @regiontype.update_attributes(params[:regiontype])
        format.html { redirect_to @regiontype, notice: 'Regiontype was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @regiontype.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /regiontypes/1
  # DELETE /regiontypes/1.json
  def destroy
    @regiontype = Regiontype.find(params[:id])
    @regiontype.destroy

    respond_to do |format|
      format.html { redirect_to regiontypes_url }
      format.json { head :ok }
    end
  end
end

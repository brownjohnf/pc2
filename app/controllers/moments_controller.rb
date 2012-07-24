class MomentsController < ApplicationController
  
  load_and_authorize_resource

  # GET /moments
  # GET /moments.json
  def index
    if params[:year]
      @year = params[:year]
      @decade = @year.to_s.truncate(2).to_i * 10
      start = "#{params[:year].to_s}-1-1".to_date
      stop = start.end_of_year
      @moments = Moment.where(:startdate=> (start)..(stop))
      @title = "Timeline | #{params[:year]}"
      render 'year'
    elsif params[:decade]
      @decade = params[:decade]
      start = "#{params[:decade].to_s}-1-1".to_date
      stop = start.end_of_year.advance(:years => 9)
      @moments = Moment.where(:startdate => (start)..(stop))
      @title = "Timeline | #{params[:decade]}s"
      render 'index'
    elsif params[:start] && params[:stop]
      start = "#{params[:start].to_s}-1-1".to_date
      stop = "#{params[:stop].to_s}-1-1".to_date
      @moments = Moment.where(:startdate => (start..stop))
      @title = "Timeline | #{params[:start]} to #{params[:stop]}"
      render 'index'
    elsif params[:all]
      @moments = Moment.all
      @title = 'All Timeline Moments'

      respond_to do |format|
        format.html
        format.json
      end
    else
      search_set = []
      10.times do
        search_set << Moment.random
      end
      @moments = Moment.where(:id => search_set).paginate(:page => params[:page], :per_page => 10)
      @title = 'Timeline | Home'
    end
  end

  # GET /moments/1
  # GET /moments/1.json
  def show
    @moment = Moment.find(params[:id])
    @year = @moment.startdate.year
    @decade = @year.to_s.truncate(2).to_i * 10
    @next = Moment.unscoped.order('moments.startdate ASC').where("startdate > ?", @moment.startdate).limit(1).first
    @prev = Moment.unscoped.order('moments.startdate DESC').where("startdate < ?", @moment.startdate).limit(1).first

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @moment }
    end
  end

  # GET /moments/new
  # GET /moments/new.json
  def new
    @moment = Moment.new
    5.times do
      @moment.photos.build
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @moment }
    end
  end

  # GET /moments/1/edit
  def edit
    @moment = Moment.find(params[:id])
    @moment.photos.build
  end

  # POST /moments
  # POST /moments.json
  def create
    @moment = current_user.moments.build(params[:moment])
    for photo in @moment.photos do
      photo.imageable_id = @moment.user.id
      photo.imageable_type = 'User'
    end

    respond_to do |format|
      if @moment.save
        format.html { redirect_to @moment, notice: 'Moment was successfully created.' }
        format.json { render json: @moment, status: :created, location: @moment }
      else
        format.html { render action: "new" }
        format.json { render json: @moment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /moments/1
  # PUT /moments/1.json
  def update
    @moment = Moment.find(params[:id])

    respond_to do |format|
      if @moment.update_attributes(params[:moment])
        format.html { redirect_to @moment, notice: 'Moment was successfully updated.' }
        format.json { respond_with_bip @moment }
      else
        format.html { render action: "edit" }
        format.json { respond_with_bip @moment }
      end
    end
  end

  # DELETE /moments/1
  # DELETE /moments/1.json
  def destroy
    @moment = Moment.find(params[:id])
    @moment.destroy

    respond_to do |format|
      format.html { redirect_to moments_url }
      format.json { head :ok }
    end
  end
    
end

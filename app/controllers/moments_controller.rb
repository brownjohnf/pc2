class MomentsController < ApplicationController
  
  skip_authorization_check

  # GET /moments
  # GET /moments.json
  def index
    if params[:year]
      start = "#{params[:year].to_s}-1-1".to_date
      stop = start.end_of_year
      @moments = Moment.where(:datapoint => (start)..(stop)).paginate(:page => params[:page], :per_page => 10)
      @title = "Timeline | #{params[:year]}"
      render 'year'
    elsif params[:decade]
      start = "#{params[:decade].to_s}-1-1".to_date
      stop = start.end_of_year.advance(:years => 9)
      @moments = Moment.where(:datapoint => (start)..(stop)).paginate(:page => params[:page], :per_page => 10)
      @title = "Timeline | #{params[:decade]}s"
      render 'index'
    elsif params[:start] && params[:stop]
      start = "#{params[:start].to_s}-1-1".to_date
      stop = "#{params[:stop].to_s}-1-1".to_date
      @moments = Moment.where(:datapoint => (start..stop)).paginate(:page => params[:page], :per_page => 10)
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

  # GET /moments
  # GET /moments.json
  def all
    @moments = Moment.paginate(:page => params[:page], :per_page => 50)
    @title = 'All Timeline Moments'

    render 'index'
  end

  # GET /moments/decade
  def decade
    start = "#{params[:id].to_s}-1-1".to_date
    stop = start.end_of_year.advance(:years => 9)
    @moments = Moment.where(:datapoint => (start)..(stop)).paginate(:page => params[:page], :per_page => 10)
    @title = "Timeline"

    render 'index'
  end

  # GET /moments/year
  def year
    start = "#{params[:id].to_s}-1-1".to_date
    stop = start.end_of_year
    @moments = Moment.where(:datapoint => (start)..(stop)).paginate(:page => params[:page], :per_page => 10)
    @title = 'Timeline'
  end

  # GET /moments/span
  def span
    start = "#{params[:start].to_s}-1-1".to_date
    stop = "#{params[:stop].to_s}-1-1".to_date
    @moments = Moment.where(:datapoint => (start..stop)).paginate(:page => params[:page], :per_page => 10)
    @title = "Timeline Span"

    render 'index'
  end

  # GET /moments/1
  # GET /moments/1.json
  def show
    @moment = Moment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @moment }
    end
  end

  # GET /moments/new
  # GET /moments/new.json
  def new
    @moment = Moment.new

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
    @moment = Moment.new(params[:moment])

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
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @moment.errors, status: :unprocessable_entity }
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

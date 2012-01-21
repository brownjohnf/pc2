class MomentsController < ApplicationController

  before_filter :authenticate, :only => [:new, :edit, :create, :update, :destroy] #sessions helper

  # GET /moments
  # GET /moments.json
  def index
    search_set = []
    10.times do
      search_set << 1+rand(Moment.count)
    end
    @moments = Moment.where(:id => search_set).paginate(:page => params[:page], :per_page => 10)
    @title = 'Timeline'
    @context_menu = { 'new' => new_moment_path }

    render 'index'
  end

  # GET /moments
  # GET /moments.json
  def all
    @moments = Moment.paginate(:page => params[:page], :per_page => 50)
    @title = 'All Timeline Moments'
    @context_menu = { 'new' => new_moment_path }

    render 'index'
  end

  # GET /moments/decade
  def decade
    start = "#{params[:id].to_s}-1-1".to_date
    stop = start.end_of_year.advance(:years => 9)
    @moments = Moment.where(:datapoint => (start)..(stop)).paginate(:page => params[:page], :per_page => 10)
    @title = "Timeline"
    @context_menu = { 'new' => new_moment_path }

    render 'index'
  end

  # GET /moments/year
  def year
    start = "#{params[:id].to_s}-1-1".to_date
    stop = start.end_of_year
    @moments = Moment.where(:datapoint => (start)..(stop)).paginate(:page => params[:page], :per_page => 10)
    @title = 'Timeline'
    @context_menu = { 'new' => new_moment_path }

    render 'index'
  end

  # GET /moments/decade
  def span
    @moments = Moment.where(:datapoint => (params[:start])..(params[:stop])).paginate(:page => params[:page], :per_page => 10)
    @title = "Timeline Span"
    @context_menu = { 'new' => new_moment_path }

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

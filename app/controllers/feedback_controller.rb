class FeedbackController < ApplicationController
  
  load_and_authorize_resource

  # GET /feedback
  # GET /feedback.json
  def index
    @feedback = Feedback.all
    @title = 'Feedback'

    respond_to do |format|
      format.html { render :layout => 'layouts/application-fluid' } # index.html.erb
      format.json { render json: @feedback }
    end
  end

  def volunteer_request
    @feedback = Feedback.new
    @title = 'Add me as a Volunteer'
  end

  # GET /feedback/1
  # GET /feedback/1.json
  def show
    @feedback = Feedback.find(params[:id])
    @title = 'View Feedback'

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @feedback }
    end
  end

  # GET /feedback/new
  # GET /feedback/new.json
  def new
    @feedback = Feedback.new
    @title = 'Give Feedback'

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @feedback }
    end
  end

  # POST /feedback
  # POST /feedback.json
  def create
    @feedback = Feedback.new(params[:feedback])

    respond_to do |format|
      if @feedback.save
        format.html { redirect_to @feedback, notice: 'Feedback was successfully created.' }
        format.json { render json: @feedback, status: :created, location: @feedback }
      else
        format.html { render action: "new" }
        format.json { render json: @feedback.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /feedback/1
  # DELETE /feedback/1.json
  def destroy
    @feedback = Feedback.find(params[:id])
    @feedback.destroy

    respond_to do |format|
      format.html { redirect_to feedback_index_url }
      format.json { head :ok }
    end
  end
end

class CaseStudiesController < ApplicationController
  
  load_and_authorize_resource

  # GET /case_studies
  # GET /case_studies.json
  def index
    @case_studies = CaseStudy.paginate(:page => params[:page], :per_page => 10)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @case_studies }
    end
  end

  def added
    @case_studies = CaseStudy.unscoped.order('created_at DESC').paginate(:page => params[:page], :per_page => 10)
    @title = 'Recuntly Added Case Studies'

    render 'index'
  end

  def updated
    @case_studies = CaseStudy.unscoped.order('updated_at DESC').paginate(:page => params[:page], :per_page => 10)
    @title = 'Recently Updated Case Studies'

    render 'index'
  end

  # GET /case_studies/1
  # GET /case_studies/1.json
  def show
    @case_study = CaseStudy.find(params[:id])
    @title = @case_study.title
    @case_studies = @case_study.find_related_tags
    @pages = Page.tagged_with(@case_study.tag_list, :any => true)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @case_study }
    end
  end

  # GET /case_studies/new
  # GET /case_studies/new.json
  def new
    @case_study = CaseStudy.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @case_study }
    end
  end

  # GET /case_studies/1/edit
  def edit
    @case_study = CaseStudy.find(params[:id])
  end

  # POST /case_studies
  # POST /case_studies.json
  def create
    @case_study = CaseStudy.new(params[:case_study])
    @contribution = @case_study.contributions.build(:user_id => current_user.id)

    respond_to do |format|
      if @case_study.save
        @contribution.save
        format.html { redirect_to @case_study, notice: 'Case study was successfully created.' }
        format.json { render json: @case_study, status: :created, location: @case_study }
      else
        format.html { render action: "new" }
        format.json { render json: @case_study.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /case_studies/1
  # PUT /case_studies/1.json
  def update
    @case_study = CaseStudy.find(params[:id])

    respond_to do |format|
      if @case_study.update_attributes(params[:case_study])
        format.html { redirect_to @case_study, notice: 'Case study was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @case_study.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /case_studies/1
  # DELETE /case_studies/1.json
  def destroy
    @case_study = CaseStudy.find(params[:id])
    @case_study.destroy

    respond_to do |format|
      format.html { redirect_to case_studies_url }
      format.json { head :ok }
    end
  end
end

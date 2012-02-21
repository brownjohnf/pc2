class PagesController < ApplicationController
  
  load_and_authorize_resource

  # GET /pages
  # GET /pages.json
  def index
    @title = 'Peruse Our Pages'
    @pages = @pages.order('lft ASC', 'title ASC')
  end

  def added
    @pages = Page.accessible_by(current_ability).unscoped.order('created_at DESC').paginate(:page => params[:page], :per_page => 10)
    @title = 'Page Feed'
    render 'feed'
  end

  def updated
    @pages = Page.accessible_by(current_ability).unscoped.order('updated_at DESC').paginate(:page => params[:page], :per_page => 10)
    @title = 'Page Feed'
    render 'feed'
  end

  # GET /pages/1
  # GET /pages/1.json
  def show
    @title = @page.title
    @pages = @page.find_related_tags
    @case_studies = CaseStudy.tagged_with(@page.tag_list, :any => true)

    #@page.ancestors.each do |a|
    #  @context_menu { a.title => a }#
    #end

    @context_menu = {'back' => pages_path, 'new' => new_page_path, 'edit' => edit_page_path}

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @page }
    end
  end

  # GET /pages/new
  # GET /pages/new.json
  def new
    @title = 'New Page'

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @page }
    end
  end

  # GET /pages/1/edit
  def edit
    @page = Page.find(params[:id])
    @title = "Edit #{@page.title}"

  end

  # POST /pages
  # POST /pages.json
  def create
    @page = Page.new(params[:page])
    @contribution = @page.contributions.build(:user_id => current_user.id)

    respond_to do |format|
      if @page.save
        @contribution.save
        format.html { redirect_to @page, notice: 'Page was successfully created.' }
        format.json { render json: @page, status: :created, location: @page }
      else
        format.html { render action: "new" }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /pages/1
  # PUT /pages/1.json
  def update
    @page = Page.find(params[:id])

    respond_to do |format|
      if @page.update_attributes(params[:page])
        format.html { redirect_to @page, notice: 'Page was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pages/1
  # DELETE /pages/1.json
  def destroy
    @page = Page.find(params[:id])
    @page.destroy

    respond_to do |format|
      format.html { redirect_to pages_url }
      format.json { head :ok }
    end
  end

  def ajax
    if params[:term]
      like= "%".concat(params[:term].concat("%"))
      pages = Page.where("lower(title) like ?", like.downcase)
    else
      pages = Page.all
    end
    list = pages.map {|u| Hash[ value: u.id, label: u.title]}
    render json: list
  end
  
end

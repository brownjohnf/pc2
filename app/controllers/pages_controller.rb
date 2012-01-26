class PagesController < ApplicationController

  before_filter :authenticate, :only => [:new, :create, :edit, :update, :destroy] #sessions helper
  before_filter :check_system, :only => :destroy

  # GET /pages
  # GET /pages.json
  def index
    @pages = Page.paginate(:page => params[:page])
    @title = 'Peruse Our Pages'

    render 'feed'
  end

  def added
    @pages = Page.unscoped.order('created_at DESC').paginate(:page => params[:page])
    @title = 'Page Feed'
    render 'feed'
  end

  def updated
    @pages = Page.unscoped.order('updated_at DESC').paginate(:page => params[:page])
    @title = 'Page Feed'
    render 'feed'
  end

  def map
    @title = 'Page Map'
  end

  # GET /pages/1
  # GET /pages/1.json
  def show
    @page = Page.find(params[:id])
    @title = @page.title
    @context_menu = {}

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
    @page = Page.new
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

    respond_to do |format|
      if @page.save
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

  private

    def check_system
      @page = Page.find(params[:id])
      redirect_to(@page, notice: 'You cannot destroy system pages.') if @page.system?
    end
end

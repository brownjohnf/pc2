class PagesController < ApplicationController
  
  load_and_authorize_resource

  # GET /pages
  # GET /pages.json
  def index
    @title = cookies[:country]#'Peruse Our Pages'
    @pages = @pages.order('lft ASC', 'title ASC')
  end
  
  def feed
    # this will be the name of the feed displayed on the feed reader
    @title = "Page Feed"

    # the news items
    @pages = Page.unscoped.order("updated_at desc")

    # this will be our Feed's update timestamp
    @updated = @pages.first.updated_at unless @pages.empty?

    respond_to do |format|
      format.atom { render :layout => false }

      # we want the RSS feed to redirect permanently to the ATOM feed
      format.rss { redirect_to feed_pages_path(:format => :atom), :status => :moved_permanently }
    end
  end
  
  def search
    @pages = Page.unscoped.search(params[:q]).paginate(:page => params[:page], :per_page => 10)
    @count = @pages.count
    
    render 'feed'
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

  # POST /pages
  # POST /pages.json
  def create
    @page = Page.new(params[:page])

    respond_to do |format|
      if @page.save!
        @contribution = @page.contributions.build(:user_id => current_user.id)
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

  def mercury_update
    page = Page.find(params[:id])

    #update page
    page.content = params[:content][:page_content][:value]
    page.save!
    
    render text: ""
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

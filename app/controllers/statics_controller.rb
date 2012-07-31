class StaticsController < ApplicationController

  skip_authorization_check

  def dashboard
    redirect_to root_path unless cookies[:splashed] == 'viewed'
    @users = User.unscoped.order('users.updated_at DESC').limit(5)
    @pages = Page.order('pages.updated_at DESC').limit(10)
    @case_studies = CaseStudy.order('updated_at DESC').limit(10)
    @photos = Photo.unscoped.order('updated_at DESC').limit(20).all
    @documents = Document.unscoped.order('updated_at DESC').limit(10).all
  end

  def splash
    @title = 'Splash'
    cookies[:splashed] = 'viewed'

    @slides = []
    Photo.order('updated_at DESC').tagged_with('splash', :on => :settings).each do |p|
      @slides << {:title => p.title, :text => p.description, :photo => p.photo.url(:wide), :link => 'view photo', :path => p} if p.photo
    end
    Page.order('updated_at DESC').tagged_with('splash', :on => :settings).each do |p|
      @slides << {:title => p.title, :text => p.description, :photo => p.photo.photo.url(:wide), :link => 'read more', :path => p} if p.photo
    end
    CaseStudy.order('updated_at DESC').tagged_with('splash', :on => :settings).each do |cs|
      @slides << {:title => cs.title, :text => cs.summary, :photo => cs.photo.photo.url(:wide), :link => 'go to case study', :path => cs} if cs.photo
    end

    @spotlights_small = []
    Photo.order('updated_at DESC').tagged_with('spotlight_small', :on => :settings).each do |p|
      @spotlights_small << {:title => p.title, :text => p.description, :photo => p.photo.url(:spotlight), :path => p} if p.photo
    end
    Page.order('updated_at DESC').tagged_with('spotlight_small', :on => :settings).each do |p|
      @spotlights_small << {:title => p.title, :text => p.content, :photo => p.photo.photo.url(:spotlight), :path => p} if p.photo
    end
    CaseStudy.order('updated_at DESC').where('photo_id IS NOT NULL', :on => :settings).tagged_with('spotlight_small').each do |cs|
      @spotlights_small << {:title => cs.title, :text => cs.summary, :photo => cs.photo.photo.url(:spotlight), :path => cs} if cs.photo
    end
    Library.order('updated_at DESC').tagged_with('spotlight_small', :on => :settings).each do |lib|
      if lib.photos.any?
        @spotlights_small << {:title => lib.canonical_title, :text => lib.description, :photo => lib.photos.first.photo.url(:spotlight), :path => lib}
      end
    end
    
    @spotlights_large = []
    Photo.order('updated_at DESC').tagged_with('spotlight_large', :on => :settings).each do |p|
      @spotlights_large << {:title => p.title, :text => p.description, :photo => p.photo.url(:spotlight), :path => p} if p.photo
    end
    Page.order('updated_at DESC').tagged_with('spotlight_large', :on => :settings).each do |p|
      @spotlights_large << {:title => p.title, :text => p.content, :photo => p.photo.photo.url(:spotlight), :path => p} if p.photo
    end
    CaseStudy.order('updated_at DESC').where('photo_id IS NOT NULL', :on => :settings).tagged_with('spotlight_large').each do |cs|
      @spotlights_large << {:title => cs.title, :text => cs.summary, :photo => cs.photo.photo.url(:spotlight), :path => cs} if cs.photo
    end
    Library.order('updated_at DESC').tagged_with('spotlight_large', :on => :settings).each do |lib|
      if lib.photos.any?
        @spotlights_small << {:title => lib.canonical_title, :text => lib.description, :photo => lib.photos.first.photo.url(:spotlight), :path => lib}
      end
    end

    respond_to do |format|
      format.html { render 'splash', :layout => 'splash' }
    end
    
  end

  def help
    @title = 'Help'
  end

  def about_us
    @title = 'About us'
  end

  def disclaimer
    @title = 'Disclaimer'
  end

  def privacy
    @title = 'Privacy Policy'
  end

  def security
    @title = 'Security'
  end
  
  def search
    @title = 'Search'
    if params[:q].present?
      @results = Search.new(params[:q]).paginate(:per_page => 50)
      redirect_to @results.first if @results.count == 1
    end
  end

  def welcome
    authorize! :read, :welcome
  end

  def goodbye
    
  end

  def timeline
    @title_photo = Photo.tagged_with('timeline_splash').first
    unless request.user_agent =~ /MSIE/
      render 'timeline', :layout => nil
    else
      redirect_to moments_path
    end
  end

end

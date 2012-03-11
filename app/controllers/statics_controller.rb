class StaticsController < ApplicationController

  skip_authorization_check

  def home
    redirect_to '/splash' unless cookies[:splashed] == 'viewed'
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
    Photo.order('updated_at DESC').tagged_with('splash').each do |p|
      @slides << {:title => p.title, :text => p.description, :photo => p.photo.url(:large), :path => p} if p.photo
    end
    Page.order('updated_at DESC').tagged_with('splash').each do |p|
      @slides << {:title => p.title, :text => p.description, :photo => p.photo.photo.url(:large), :path => p} if p.photo
    end
    CaseStudy.order('updated_at DESC').tagged_with('splash').each do |cs|
      @slides << {:title => cs.title, :text => cs.summary, :photo => cs.photo.photo.url(:large), :path => cs} if cs.photo
    end
    @spotlights = []
    Photo.order('updated_at DESC').tagged_with('spotlight').each do |p|
      @spotlights << {:title => p.title, :text => p.description, :photo => p.photo.url(:large), :path => p} if p.photo
    end
    Page.order('updated_at DESC').tagged_with('spotlight').each do |p|
      @spotlights << {:title => p.title, :text => p.content, :photo => p.photo.photo.url(:medium), :path => p} if p.photo
    end
    CaseStudy.order('updated_at DESC').where('photo_id IS NOT NULL').tagged_with('spotlight').each do |cs|
      @spotlights << {:title => cs.title, :text => cs.summary, :photo => cs.photo.photo.url(:medium), :path => cs} if cs.photo
    end

    render 'splash', :layout => 'splash'
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
  end
end

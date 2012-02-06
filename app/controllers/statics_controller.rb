class StaticsController < ApplicationController

  def home
    redirect_to '/splash' unless cookies[:splashed] == 'viewed'
    @users = User.unscoped.order('users.updated_at DESC').limit(5)
    @pages = Page.order('pages.updated_at DESC').limit(10)
    @case_studies = CaseStudy.order('updated_at DESC').limit(10)
    @photos = Photo.unscoped.order('updated_at DESC').limit(20).all
    @documents = Document.unscoped.order('updated_at DESC').limit(20).all
  end

  def splash
    @title = 'Splash'
    cookies[:splashed] = 'viewed'
    @slides = []
    Photo.order('updated_at DESC').tagged_with('splash').each do |p|
      @slides << {:title => p.title, :text => p.description, :photo => p.photo.url(:large), :path => p}
    end
    @spotlights = []
    Photo.order('updated_at DESC').tagged_with('spotlight').each do |p|
      @spotlights << {:title => p.title, :text => p.description, :photo => p.photo.url(:medium), :path => p}
    end
    Page.order('updated_at DESC').tagged_with('spotlight').each do |p|
      @spotlights << {:title => p.title, :text => p.description, :photo => p.photo.photo.url(:medium), :path => p}
    end

    render 'splash', :layout => 'splash'
  end

  def help
    @title = 'Help'
  end

  def about_us
    @page = Page.where(:title => 'About us').first
    @title = @page.title
    render 'pages/show'
  end

  def disclaimer
    @page = Page.where(:title => 'Disclaimer').first
    @title = @page.title
    render 'pages/show'
  end

  def privacy
    @page = Page.where(:title => 'Privacy Policy').first
    @title = @page.title
    render 'pages/show'
  end

  def support
    @page = Page.where(:title => 'Support').first
    @title = @page.title
    render 'pages/show'
  end

  def security
    @page = Page.where(:title => 'Security').first
    @title = @page.title
    render 'pages/show'
  end

end

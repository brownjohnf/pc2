class StaticsController < ApplicationController

  def home
    redirect_to '/splash' unless cookies[:splashed] == 'viewed'
    @users = User.order('users.updated_at DESC').limit(10)
    @pages = Page.order('pages.updated_at DESC').limit(10)
  end

  def splash
    @title = 'Splash'
    cookies[:splashed] = 'viewed'
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
    @page = Page.where(:title => 'About us').first
    @title = @page.title
    render 'pages/show'
  end

end

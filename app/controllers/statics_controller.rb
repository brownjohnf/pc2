class StaticsController < ApplicationController

  def home
    if signed_in?
      @users = Group.find_by_name('Administrator').users
      @pages = Page.order('updated_at DESC').paginate(:page => params[:page])
    else
      redirect_to splash_path
    end
  end

  def splash
    @title = 'Splash'
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

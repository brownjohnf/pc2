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

end

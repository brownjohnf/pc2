class StaticsController < ApplicationController

  def home
    @users = Group.find_by_name('Administrator').users
    @pages = Page.order('updated_at DESC').paginate(:page => params[:page])
  end

  def splash
  end

  def feedback
    @title = 'Feedback'
  end

end

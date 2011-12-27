class StaticsController < ApplicationController

  def home
    @users = Group.find_by_name('Administrator').users
  end

  def about_us
    @title = 'About us'
  end

  def disclaimer
    @title = 'Disclaimer'
  end

  def privacy_policy
    @title = 'Privacy Policy'
  end

  def support
    @title = 'Support'
  end

  def security
    @title = 'Security'
  end

end

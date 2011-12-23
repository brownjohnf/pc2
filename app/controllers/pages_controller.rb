class PagesController < ApplicationController

  def home
    @users = User.find_by_admin(true)
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

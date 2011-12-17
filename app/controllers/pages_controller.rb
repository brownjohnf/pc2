class PagesController < ApplicationController

  def home
    if signed_in?
      render :text => "You have successfully logged in as #{current_user.name}."
    else
      render :text => 'You have not logged in. By default, this template supports login via Facebook (/auth/facebook), Github (/auth/github), and Twitter (/auth/twitter [will not work from localhost]). Please try one of these to ensure that the system is working.'
    end
  end

end

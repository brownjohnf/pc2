class SessionsController < ApplicationController

  def new
  end

  def create
#    render :text => request.env['omniauth.auth'].inspect
    auth_hash = request.env['omniauth.auth']

    if signed_in? #session[:user_id]
      # Means our user is signed in. Add the authorization to the user
      User.find(current_user).add_provider(auth_hash)

      redirect_back_or root_path
    else
      # Log him/her in or sign 'em up
      user = Authorization.find_or_create(auth_hash)

      # Create the session
      #session[:user_id] = auth.user.id
      sign_in user

      redirect_back_or current_user
      #render :text => "Welcome #{auth.user.name}!"
    end
  end

  def destroy
    sign_out
    redirect_to root_path
    #render :text => "You've logged out!"
  end

end

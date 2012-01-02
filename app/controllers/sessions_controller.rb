class SessionsController < ApplicationController

  def new
  end

  def create
#    render :text => request.env['omniauth.auth'].inspect
    auth_hash = request.env['omniauth.auth']

    if signed_in? #session[:user_id]
      # Means our user is signed in. Add the authorization to the user
      User.find(current_user).add_provider(auth_hash)

      redirect_back_or current_user
      #render :text => "You can now login using #{auth_hash["provider"].capitalize} too!"
    else
      # Log him in or sign him up
      user = Authorization.find_or_create(auth_hash)

      # Create the session
      #session[:user_id] = auth.user.id
      sign_in user

      redirect_back_or current_user
      #render :text => "Welcome #{auth.user.name}!"
    end
  end

  def failure
    #render :text => "Sorry, but there was a problem with the authorization."
    auth_hash = request.env['omniauth.auth']

    render :text => auth_hash.inspect
  end

  def destroy
    sign_out
    redirect_to root_path
    #render :text => "You've logged out!"
  end

end

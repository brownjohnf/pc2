module SessionsHelper

  def deny_access
    store_location
    redirect_to login_path, :notice => 'Please sign in to access this page.'
  end
  
  def deny_owner
    redirect_to root_path, :notice => 'Please sign in as the owner of this resource to edit it.'
  end
  
  def deny_admin
    redirect_to root_path, :notice => 'You must be an admin to access these resources.'
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    clear_return_to
  end

  private

    def store_location
      session[:return_to] = request.fullpath
    end

    def clear_return_to
      session[:return_to] = nil
    end

end

class ApplicationController < ActionController::Base
  
  protect_from_forgery
  
  check_authorization :unless => :devise_controller?
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end
  
  include SessionsHelper
  include Carmen

  protected

    def ckeditor_filebrowser_scope(options = {})
      Photo.all
    end
end

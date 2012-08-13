class ApplicationController < ActionController::Base

  before_filter :handle_cookies
  before_filter :check_for_users
  before_filter :define_current_user
  
  protect_from_forgery
  
  check_authorization :unless => :devise_controller?
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to login_path, alert: exception.message
  end
  
  include SessionsHelper
  include Carmen

  def handle_cookies
    if params[:country]
      cookies[:country] = params[:country]
    else
      cookies[:country] ||= 'SN'
    end
  end

  def check_for_users
    if User.any?
      #redirect_to login_path
    end
  end

  def define_current_user
    User.current_user = current_user
  end

  def after_sign_in_path_for(resource)
    request.env['omniauth.origin'] || stored_location_for(resource) || entry_path
  end

  def after_sign_out_path_for(resource_or_scope)
    exit_path
  end

end

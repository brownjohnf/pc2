class ApplicationController < ActionController::Base

  before_filter :handle_cookies
  
  protect_from_forgery
  
  check_authorization :unless => :devise_controller?
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end
  
  include SessionsHelper
  include Carmen

  def handle_cookies
    cookies[:country] ||= 'SN'
  end

end

class UserMailer < ActionMailer::Base
  default :from => "admin@pcsenegal.org"
 
  def signup_notification(user)
    @user = user
    @url  = "http://www.pcsenegal.com/login"
    mail(:to => user.email, :subject => "Welcome to My Awesome Site")
  end
end
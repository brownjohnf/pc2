class UserMailer < ActionMailer::Base
  default :from => "admin@pcsenegal.org"
 
  def signup_notification(user)
    @user = user
    @url  = "http://" + request.path + "/login"
    mail(:to => user.email, :subject => "Welcome to My Awesome Site")
  end
end

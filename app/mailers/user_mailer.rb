class UserMailer < ActionMailer::Base
 
  def signup_notification(user)
    recipients "#{user.name} <#{user.email}"
    from 'Peace Corps Senegal'
    subject 'Congrats!'
    sent_on Time.now
    body {
      :user => user,
      :url => "http://www.pcsenegal.org"
    }
  end

end

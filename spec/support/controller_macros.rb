module ControllerMacros

  # moments
  def bad_moment_attributes
    before(:each) do
      @attr = {
        :title => '',
        :summary => '',
        :datapoint => ''
      }
    end
  end

  def good_moment_attributes
    before(:each) do
      @attr = {
        :title => 'Test Moment Title',
        :summary => 'Test moment summary',
        :datapoint => Time.now.years_ago(1).to_date
      }
    end
  end

  # user login management

  def login_user
    before(:each) do
      @request.env["devise_mapping"] = Devise.mappings[:user]
      @user = Factory.create(:user)
      @user.confirm!
      sign_in @user
    end
  end

  def login_volunteer
    before(:each) do
      @request.env["devise_mapping"] = Devise.mappings[:user]
      @user = Factory.create(:user)
      @user.roles << Role.find_or_create_by_name('Volunteer')
      @user.confirm!
      sign_in @user
    end
  end

  def login_staff
    before(:each) do
      @request.env["devise_mapping"] = Devise.mappings[:user]
      @user = Factory.create(:user)
      @user.roles << Role.find_or_create_by_name('Staff')
      @user.confirm!
      sign_in @user
    end
  end

  def login_admin
    before(:each) do
      @request.env["devise_mapping"] = Devise.mappings[:user]
      @user = Factory.create(:user)
      @user.roles << Role.find_or_create_by_name('Admin')
      @user.confirm!
      sign_in @user
    end
  end

  def login_moderator
    before(:each) do
      @request.env["devise_mapping"] = Devise.mappings[:user]
      @user = Factory.create(:user)
      @user.roles << Role.find_or_create_by_name('Moderator')
      @user.confirm!
      sign_in @user
    end
  end

  # page attributes
  
  def bad_page_attributes
    before(:each) do
      @attr = {
        :title => '',
        :description => '',
        :content => '',
        :language_id => ''
      }
    end
  end

  def good_page_attributes
    before(:each) do
      @attr = {
        :title => 'Test Title',
        :description => 'Test Description',
        :content => 'Test content.',
        :language_id => 2
      }
    end
  end

end

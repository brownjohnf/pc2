module ControllerMacros

  # user login management

  def login_guest
    before (:each) do
      @user = User.new
      @user.roles << Role.find_or_create_by_name('Public')
    end
  end    
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

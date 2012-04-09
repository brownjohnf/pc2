require 'spec_helper'

describe StaticsController do

  render_views

  describe "GET 'dashboard'" do
    it 'should be successful with a splashed=viewed cookie' do
      @request.cookies[:splashed] = 'viewed'
      get :dashboard
      response.should be_success
    end
    it 'should redirect to splash without a cookie' do
      get :dashboard
      response.should redirect_to root_path
    end
  end

  describe "GET 'security'" do
    it 'should be successful' do
      get :security
      response.should be_success
    end
    it 'should have the right title' do
      get :security
      response.should have_selector('h1', :content => 'Security')
    end
  end

  describe "GET 'welcome'" do
    context 'as user' do
      login_user
      it 'should be successful' do
        get :welcome
        response.should be_success
      end
      it 'should have the right title' do
        get :welcome
        response.should have_selector('h1', :content => 'Welcome')
      end
    end
    context 'as guest' do
      it 'should redirect to root path' do
        get :welcome
        response.should redirect_to login_path
      end
    end
  end

  describe "GET 'goodbye'" do
    it 'should be successful' do
      get :goodbye
      response.should be_success
    end
    it 'should have the right title' do
      get :goodbye
      response.should have_selector('h1', :content => 'Goodbye')
    end
  end

  describe "GET 'splash'" do
    it 'should be successful' do
      get :splash
      response.should be_success
    end
    it 'should set a splashed=viewed cookie' do
      get :splash
      response.cookies[:splashed].should == 'viewed'
    end
    it 'should have a slider' do
      get :splash
      response.should have_selector('div', :class => 'carousel')
    end
    it 'should have thumbnails' do
      get :splash
      response.should have_selector('ul', :class => 'thumbnails')
    end
  end

  describe "GET 'help'" do
    it 'should be successful' do
      get :help
      response.should be_success
    end
    it 'should have the right title' do
      get :help
      response.should have_selector('h1', :content => 'Help')
    end
  end

  describe "GET 'about us'" do
    it 'should be successful' do
      get :about_us
      response.should be_success
    end
    it 'should have the right title' do
      get :about_us
      response.should have_selector('h1', :content => 'About')
    end
  end

  describe "GET 'disclaimer'" do
    it 'should be successful' do
      get :disclaimer
      response.should be_success
    end
    it 'should have the right title' do
      get :disclaimer
      response.should have_selector('h1', :content => 'Disclaimer')
    end
  end

  describe "GET 'privacy policy'" do
    it 'should be successful' do
      get :privacy
      response.should be_success
    end
    it 'should have the right title' do
      get :privacy
      response.should have_selector('h1', :content => 'Privacy')
    end
  end

  describe "GET 'search'" do
    it 'should be successful' do
      get :search
      response.should be_success
    end
    it 'should have the right title' do
      get :search
      response.should have_selector('h1', :content => 'Search')
    end
  end

  describe "'GET' timeline" do
    it 'should be successful' do
      get :timeline
      response.should be_success
    end
    it 'should have the verite timeline present' do
      get :timeline
      response.should have_selector('div', :id => 'timeline-embed')
    end
  end

end

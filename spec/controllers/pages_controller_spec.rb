require 'spec_helper'

describe PagesController do
  before (:each) do
    #@page = Factory(:page)
    @user = User.new(:name => 'test user', :email => 'testuser@example.com', :password => 'testing')
    @user.roles << Role.find_or_create_by_name('Public')
    @user.save
    sign_in @user
    @user.confirm!
  end
  include Devise::TestHelpers
  #render_views
  Role.create(:name => 'Public')
  describe "GET 'index'" do
    it 'should be successful' do
      get 'index'
      puts response.body
      response.should be_success
    end
  end
  describe "GET 'feed'" do
    it 'should be successful if there are pages' do
      @page = Page.new(:title => 'test', :description => 'description', :content => 'content', :language_id => 1)
      get 'feed'
      puts response.body
      response.should be_success
    end
  end
  describe "GET 'search'" do
    it 'should be successful' do
      get 'search'
      response.should be_success
    end
  end
  describe "GET 'added'" do
    it 'should be successful' do
      get 'added'
      response.should be_success
    end
  end
  describe "GET 'updated'" do
    it 'should be successful' do
      get 'updated'
      response.should be_success
    end
  end
  describe "GET 'show'" do
    it 'should be successful' do
      get 'show'
      response.should be_success
    end
  end
  describe "GET 'new'" do
    it 'should only allow volunteers and staff access' do
      get 'new'
      response.should_not be_success
    end
    it 'should be successful if signed in' do
      @user = Factory(:user)
      sign_in @user
      get 'new'
      response.should be_success
    end
  end
  describe "POST 'create'" do
    it 'should be successful' do
      post 'create'
      response.should be_success
    end
  end
  describe "PUT 'update'" do
    it 'should be successful' do
      put 'update'
      response.should be_success
    end
  end
  describe "POST 'mercury_update'" do
    it 'should be successful' do
      post 'mercury_update'
      response.should be_success
    end
  end
  describe "DELETE 'destroy'" do
    it 'should be successful' do
      delete 'destroy'
      response.should be_success
    end
  end
  describe "GET 'ajax'" do
    it 'should be successful' do
      get 'ajax'
      response.should be_success
    end
  end
  
end

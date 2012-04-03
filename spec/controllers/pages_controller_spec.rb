require 'spec_helper'

describe PagesController do
  before (:each) do
    @user = User.new
    @user.roles << Role.find_or_create_by_name('Public')
  end
  include Devise::TestHelpers
  #render_views

  describe 'access control' do
    it 'should deny access to new' do
      get :new
      response.should redirect_to login_path
    end
    it 'should deny access to create' do
      post :create
      response.should redirect_to login_path
    end
    it 'should deny access to mercury update' do
      get :mercury_update
      response.should redirect_to login_path
    end
    it 'should deny access to update' do
      put :update
      response.should redirect_to login_path
    end
    it 'should deny access to destroy' do
      delete :destroy
      response.should redirect_to login_path
    end
    it 'should allow access to index' do
      get :index
      response.should_not redirect_to login_path
    end
    it 'should allow access to show' do
      @page = Factory.create(:page)
      get :show, :id => @page
      response.should_not redirect_to login_path
    end
    it 'should allow access to updated' do
      get :updated
      response.should_not redirect_to login_path
    end
    it 'should deny access to added' do
      get :added
      response.should_not redirect_to login_path
    end
    it 'should allow access to feed' do
      get :feed
      response.should_not redirect_to login_path
    end
  end    

  describe "GET 'index'" do
    it 'should be successful' do
      get 'index'
      puts response.body
      response.should be_success
    end
  end
  describe "GET 'feed'" do
    it 'should be successful' do 
      get 'feed'
      puts response.body
      response.should be_success
    end
  end
  describe "GET 'search'" do
    it 'should be successful with a query present' do
      get :search, {:q => 'test'}
      response.should be_success
    end
    it 'should redirect without a query present' do
      get :search
      response.should redirect_to(pages_path)
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
    before(:each) do
      @page = Factory.create(:page)
    end
    it 'should be successful' do
      get 'show', :id => @page
      response.should be_success
    end
    it 'should be the correct page' do
      get :show, :id => @page
      assigns(:page).should == @page
    end
  end
  
  describe "GET 'new'" do
    before(:each) do
      sign_in(@user = Factory.create(:user))
      @user.confirm!
      @user.roles << Role.find_or_create_by_name('User')
    end
    describe 'should be successful' do
      it 'if volunteer' do
        @user.roles << Role.find_or_create_by_name('Volunteer')
        get 'new'
        response.should be_success
      end
      it 'if staff' do
        @user.roles << Role.find_or_create_by_name('Staff')
        get 'new'
        response.should be_success
      end
    end
    describe 'should fail' do
      it 'if not a volunteer or staff member' do
        get 'new'
        response.should redirect_to(login_path)
      end
    end
  end

  describe "POST 'create'" do
    before(:each) do
      sign_in(@user = Factory.create(:user))
      @user.confirm!
      @user.roles << Role.find_or_create_by_name('User')
    end
    describe 'should be successful' do
      before(:each) do
        @attr = {
          :title => 'Test Title',
          :description => 'Test Description',
          :content => 'Test content.',
          :language_id => 1
        }
      end
      describe 'when volunteer and' do
        before(:each) do
          @user.roles << Role.find_or_create_by_name('Volunteer')
        end
        it 'should create a page' do
          lambda do
            post :create, :page => @attr
          end.should change(Page, :count).by(1)
        end
        it 'should redirect to newly created page' do
          post :create, :page => @attr
          response.should redirect_to(pages_path assigns[:page])
        end
        it 'should have a success message' do
          post :create, :page => @attr
          flash[:success].should =~ /success/i
        end
      end
    end
  end

  describe "PUT 'update'" do
    it 'should be successful if user is contributor and volunteer' do
      @user.roles << Role.find_or_create_by_name('Volunteer')
      Contribution.create!(:user_id => @user.id, :contributable_type => 'Page', :contributable_id => @page.id)
      put 'update', {:id => @page.id, :page => @page}
      puts response.params
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
    it 'should be successful if user is contributor' do
      delete 'destroy', {:id => @page.id}
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

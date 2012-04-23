require 'spec_helper'

describe UsersController do

  render_views

  before(:each) do
    @user2 = Factory.create(:user)
  end
  
  # GET index
  describe "'GET' index" do
    context 'as anyone' do
      it 'should be successful' do
        get :index
        response.should be_success
      end
    end
  end

  # GET table
  describe "'GET' table" do
    context 'as anyone' do
      it 'should redirect to login' do
        get :table
        response.should redirect_to login_path
      end
    end
    context 'as user' do
      login_user
      it 'should not be successful' do
        get :table
        response.should redirect_to login_path
      end
    end
    context 'as volunteer' do
      login_volunteer
      it 'should be successful' do
        get :table
        response.should be_success
      end
      it 'should have a table' do
        get :table
        response.should have_selector('table')
      end
    end
  end

  # GET search
  describe "'GET' search" do
    context 'as user' do
      login_user
      it 'should be successful with a query present and postgres' do
        get :search, :q => 'test'
        response.should be_success
      end
      it 'should redirect to users path without a query present' do
        get :search
        response.should redirect_to users_path
      end
    end
  end

  # GET show
  describe "'GET' show" do
    context 'as anyone' do
      it 'should be successful' do
        get :show, :id => @user2.id
        response.should be_success
      end
      it 'should retrieve the correct user' do
        get :show, :id => @user2.id
        response.should have_selector('h1', :content => @user2.name)
      end
    end
  end

  # GET edit
  describe "'GET' edit" do
    context 'as admin' do
      login_admin
      it 'should be successful' do
        get :edit, :id => @user2
        response.should be_success
      end
    end
  end

  # PUT update
  describe "'PUT' update" do
    before(:each) do
      @attr = {
        :name => 'test'
      }
    end
    context 'as admin' do
      login_admin
      it 'should be successful' do
        put :update, :id => @user2, :user => @attr
        response.should be_success
      end
    end
  end

  # DELETE destroy
  describe "'DELETE' destroy" do
    context 'as admin' do
      login_admin
      it 'should destroy the user' do
        lambda do
          delete :destroy, :id => @user2
        end.should change(User, :count).by(-1)
      end
      it 'should redirect to users path' do
        delete :destroy, :id => @user2
        response.should redirect_to users_path
      end
    end
    context 'as anyone' do
      it 'should not destroy the user' do
        lambda do
          delete :destroy, :id => @user2
        end.should_not change(User, :count).by(-1)
      end
      it 'should redirect to login' do
        delete :destroy, :id => @user2
        response.should redirect_to login_path
      end
    end
    context 'as a volunteer' do
      login_volunteer
      it 'should not destroy the user' do
        lambda do
          delete :destroy, :id => @user2
        end.should_not change(User, :count).by(-1)
      end
      it 'should redirect to login' do
        delete :destroy, :id => @user2
        response.should redirect_to login_path
      end
    end
    context 'as staff' do
      login_staff
      it 'should not destroy the user' do
        lambda do
          delete :destroy, :id => @user2
        end.should_not change(User, :count).by(-1)
      end
      it 'should redirect to login' do
        delete :destroy, :id => @user2
        response.should redirect_to login_path
      end
    end
  end

end

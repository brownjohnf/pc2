require 'spec_helper'

describe UsersController do

  render_views
  
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
      it 'should be successful' do
        get :table
        response.should be_successful
      end
      it 'should have a table' do
        get :table
        response.should have_selector('table')
      end
    end
  end

  # GET search
  describe "'GET' search" do
    context 'as admin' do
      login_admin
      it 'should be successful with postgres' do
        get :search, :q => 'test'
        response.should be_success
      end
    end
  end

  # GET show
  describe "'GET' show" do
    context 'as anyone' do
      it 'should redirect to login' do
        get :show, :id => Factory(:user)
        response.should redirect_to login_path
      end
    end
    context 'as user' do
      login_user
      it 'should be successful' do
        get :show, :id => Factory(:user)
        response.should be_success
      end
    end
  end

  # GET edit
  describe "'GET' edit" do
    context 'as admin' do
      login_admin
      it 'should be successful' do
        get :edit
        response.should be_success
      end
    end
  end

  # PUT update
  describe "'PUT' update" do
    context 'as admin' do
      login_admin
      it 'should be successful' do
        put :update
        response.should be_success
      end
    end
  end

  # DELETE destroy
  describe "'DELETE' destroy" do
    context 'as admin' do
      login_admin
      it 'should be successful' do
        delete :destroy
        response.should be_success
      end
    end
  end

  # PUT remove_avatar 
  describe "'PUT' remove_avatar" do
    context 'as admin' do
      login_admin
      it 'should be successful' do
        put :remove_avatar
        response.should be_success
      end
    end
  end
end

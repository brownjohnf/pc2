require 'spec_helper'

describe UsersController do
  include Devise::TestHelpers

  render_views
  
  # GET index
  describe "'GET' index" do
    context 'as anyone' do
      login_guest
      it 'should be successful' do
        get :index
        response.should be_success
      end
    end
  end

  # GET table
  describe "'GET' table" do
    context 'as anyone' do
      login_guest
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

  # GET show
  describe "'GET' show" do
    context 'as anyone' do
      login_guest
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
  #
  # PUT update
  #
  # DELETE destroy
  #
  # PUT remove_avatar 
end

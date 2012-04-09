require 'spec_helper'

describe MomentsController do

  render_views

  describe "'GET' index" do
    it 'should be successful' do
      get :index
      response.should be_success
    end
    it 'should respond to JSON request' do
      get :index, :all => true, :format => 'json'
      response.should be_success
    end
  end

  describe "'GET' edit" do
    context 'as anyone' do
      before(:each) do
        @moment = Factory.create(:moment)
      end
      it 'should fail' do
        get :edit, :id => @moment
        response.should_not be_success
      end
    end
    context 'as user' do
      login_user
      describe 'who is owner' do
        before(:each) do
          @moment = Factory.create(:moment, :user => @user)
        end
        it 'should be successful' do
          get :edit, :id => @moment
          puts response.body.inspect
          response.should be_success
        end
      end
    end
    context 'as admin' do
      before(:each) do
        @moment = Factory.create(:moment)
      end
      login_admin
      it 'should be successful' do
        get :edit, :id => @moment
        response.should be_success
      end
    end
  end
end

require 'spec_helper'

describe UsersController do

  render_views

  describe "'GET' index" do
    it 'should be successful' do
      get :index
      response.should be_success
    end
    it 'should respond to JSON request' do
      get :index, :format => 'json'
      response.should be_success
    end
  end
end

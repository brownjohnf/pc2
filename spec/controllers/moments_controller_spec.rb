require 'spec_helper'

describe MomentsController do

  render_views
  
  # GET index
  describe "'GET' index" do
    it 'should respond to all paramater' do
      get :index, :all => true
      response.should be_success
      response.should render_template 'index'
    end
    it 'should respond to JSON request' do
      get :index, :all => true, :format => 'json'
      response.should be_success
    end
    it 'should respond to year parameter' do
      get :index, :year => (1963 + rand(50))
      response.should be_success
      response.should render_template 'year'
    end
    it 'should respond to decade parameter' do
      get :index, :decade => (196 + rand(5) * 10)
      response.should be_success
      response.should render_template 'index'
    end
    it 'should respond to start/stop parameters' do
      start = (1963 + rand(50))
      get :index, :start => start, :stop => (start + 5)
      response.should be_success
      response.should render_template 'index'
    end
    it 'should render random 10 without both start/stop' do
      get :index, :start => (1963 + rand(50))
      response.should render_template 'index'
    end
    it 'should render random 10 without both start/stop' do
      get :index, :stop => (1963 + rand(50))
      response.should render_template 'index'
      response.should_not have_selector('h1', :content => 'to')
    end
  end

  # GET show
  describe "'GET' show" do
    before(:each) do
      @moment = Factory.create(:moment)
    end
    context 'as anyone' do
      it 'should be successful' do
        get :show, :id => @moment
        response.should be_success
      end
      it 'should be the correct moment' do
        get :show, :id => @moment
        assigns(:moment).should == @moment
      end
      it 'should have the right title' do
        get :show, :id => @moment
        response.should have_selector('h1', :content => @moment.title)
      end
    end
  end

  # GET new
  describe"'GET' new" do
    context 'as guest' do
      it 'should redirect to login' do
        get :new
        response.should redirect_to login_path
      end
    end
    context 'as user' do
      login_user
      it 'should redirect to login' do
        get :new
        response.should redirect_to login_path
      end
    end
    context 'as volunteer' do
      login_volunteer
      it 'should be successful' do
        get :new
        response.should be_success
      end
    end
    context 'as staff' do
      login_staff
      it 'should be successful' do
        get :new
        response.should be_success
      end
    end
  end

  # POST create
  describe "'POST' create" do
    context 'as guest' do
      it 'should redirect to login' do
        post :create
        response.should redirect_to login_path
      end
    end
    describe 'with bad attributes' do
      bad_moment_attributes
      context 'as admin' do
        login_admin
        it 'should not create a new moment' do
          lambda do
            post :create, :moment => @attr
          end.should_not change(Moment, :count).by(1)
        end
        it 'should render the new moment form' do
          post :create, :moment => @attr
          response.should render_template 'new'
        end
      end
    end
    describe 'with good content' do
      good_moment_attributes
      context 'as guest' do
        it 'should not create a moment' do
          lambda do
            post :create, :moment => @attr
          end.should_not change(Moment, :count).by(1)
        end
      end
      context 'as user' do
        login_user
        it 'should not create a moment' do
          lambda do
            post :create, :moment => @attr
          end.should_not change(Moment, :count).by(1)
        end
      end
      context 'as staff' do
        login_staff
        it 'should create a moment' do
          lambda do
            post :create, :moment => @attr
          end.should change(Moment, :count).by(1)
        end
        it 'should redirect to newly created moment' do
          post :create, :moment => @attr
          response.should redirect_to assigns[:moment]
        end
        it 'should have a success message' do
          post :create, :moment => @attr
          flash[:notice].should =~ /success/i
        end
      end
      context 'as volunteer' do
        login_volunteer
        it 'should create a moment' do
          lambda do
            post :create, :moment => @attr
          end.should change(Moment, :count).by(1)
        end
        it 'should redirect to newly created moment' do
          post :create, :moment => @attr
          response.should redirect_to assigns[:moment]
        end
        it 'should have a success message' do
          post :create, :moment => @attr
          flash[:notice].should =~ /success/i
        end
      end
    end
  end

  # GET edit
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
          response.should be_success
        end
      end
      describe 'who is not owner' do
        before(:each) do
          @moment = Factory.create(:moment)
        end
        it 'should redirect to login' do
          get :edit, :id => @moment
          response.should redirect_to login_path
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

  # PUT update
  describe "'PUT' update" do
    describe 'with bad content' do
      before(:each) do
        @moment = Factory.create(:moment)
      end
      bad_moment_attributes
      context 'as admin' do
        login_admin
        it 'should render the edit page' do
          put :update, :id => @moment, :moment => @attr
          response.should render_template 'edit'
        end
      end
    end
    describe 'with good content' do
      good_moment_attributes
      context 'as non-owner' do
        before(:each) do
          @moment = Factory.create(:moment)
        end
        login_user
        it 'should redirect to login' do
          put :update, :id => @moment, :moment => @attr
          response.should redirect_to login_path
        end
        it 'should not change the moment attributes' do
          put :update, :id => @moment, :moment => @attr
          @moment.reload
          @moment.title.should_not == @attr[:title]
        end
      end
      context 'as owner' do
        login_user
        before(:each) do
          @moment = Factory.create(:moment, :user => @user)
        end
        it 'should change the moment attributes' do
          put :update, :id => @moment, :moment => @attr
          @moment.reload
          @moment.title.should == @attr[:title]
          @moment.summary.should == @attr[:summary]
          @moment.datapoint.should == @attr[:datapoint]
        end
        it 'should redirect to the moment' do
          put :update, :id => @moment, :moment => @attr
          response.should redirect_to assigns[:moment]
        end
      end
    end
  end

  # DELETE destroy
  describe "'DELETE' destroy" do
    context 'as guest' do
      before(:each) do
        @moment = Factory.create(:moment)
      end
      it 'should not destroy the moment' do
        lambda do
          delete :destroy, :id => @moment
        end.should_not change(Moment, :count).by(-1)
      end
      it 'should redirect to login' do
        delete :destroy, :id => @moment
        response.should redirect_to login_path
      end
    end
    context 'as user' do
      login_user
      describe 'who is not owner' do
        before(:each) do
          @moment = Factory.create(:moment)
        end
        it 'should not destroy the moment' do
          lambda do
            delete :destroy, :id => @moment
          end.should_not change(Moment, :count).by(-1)
        end
        it 'should redirect to login' do
          delete :destroy, :id => @moment
          response.should redirect_to login_path
        end
      end
      describe 'who is owner' do
        before(:each) do
          @moment = Factory.create(:moment, :user => @user)
        end
        it 'should destroy the moment' do
          lambda do
            delete :destroy, :id => @moment
          end.should change(Moment, :count).by(-1)
        end
        it 'should redirect to moments path' do
          delete :destroy, :id => @moment
          response.should redirect_to moments_path
        end
      end
    end
  end
end

require 'spec_helper'

describe PhotosController do
  
  render_views

  # GET index
  describe "GET 'index'" do
    context 'as anyone' do
      it 'should be successful' do
        get :index
        response.should be_success
      end
    end
  end

  # GET search
  describe "GET 'search'" do
    context 'as anyone' do
      it 'should be successful with a query present and postgres' do
        get :search, {:q => 'test'}
        response.should be_success
      end
      it 'should redirect to photos without a query present' do
        get :search
        response.should redirect_to photos_path
      end
    end
  end

  # GET show
  describe "GET 'show'" do
    before(:each) do
      @photo = Factory.create(:photo)
    end
    context 'as anyone' do
      it 'should be successful' do
        get :show, :id => @photo
        response.should be_success
      end
      it 'should be the correct photo' do
        get :show, :id => @photo
        assigns(:photo).should == @photo
      end
    end
  end
  
  # GET new
  describe "'GET' new" do
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

  # GET edit
  describe "'GET' edit'" do
    context 'as guest' do
      before(:each) do
        @photo = Factory.create(:photo)
      end
      it 'should redirect to login' do
        get :edit, :id => @photo
        response.should redirect_to login_path
      end
    end
    context 'as a user' do
      login_user
      describe 'who is owner' do
        before(:each) do
          @photo = Factory.create(:photo, :user => @user)
        end
        it 'should be successful' do
          get :edit, :id => @photo
          response.should be_success
        end
      end
      describe 'who is not owner' do
        before(:each) do
          @photo = Factory.create(:photo)
        end
        it 'should redirect to login' do
          get :edit, :id => @photo
          response.should redirect_to login_path
        end
      end
    end
  end

  # POST create
  describe "POST 'create'" do
    context 'as guest' do
      it 'should redirect to login path' do
        post :create
        response.should redirect_to login_path
      end
    end
    describe 'no-content failure' do
      before(:each) do
        @attr = {
          :photo => nil
        }
      end
      context 'as admin' do
        login_admin
        it 'should not create a photo' do
          lambda do
            post :create, :photo => @attr
          end.should_not change(Photo, :count).by(1)
        end
        it 'should render the new photo form' do
          post :create, :photo => @attr
          response.should render_template 'photos/new'
        end
      end
    end
    describe 'should be successful' do
      before(:each) do
        @attr = {
          :photo => File.new(File.join(Rails.root, 'spec', 'support', 'test.png'))
        }
      end
      context 'as admin' do
        login_admin
        it 'should create a photo' do
          lambda do
            puts @attr.inspect
            post :create, :photo => @attr
            pp assigns(:photo).errors
          end.should change(Photo, :count).by(1)
        end
        it 'should allow assignment of photo' do
          @photo = Factory.create(:photo)
          @photo.photo = File.new(File.join(Rails.root, 'spec', 'support', 'test.txt'))
          @photo.title = 'Fuck'
          pp @photo.inspect
          @photo.save!
          pp @photo.inspect
        end
        it 'should redirect to newly created photo' do
          post :create, :photo => @attr
          response.should redirect_to assigns[:photo]
        end
        it 'should have a success message' do
          post :create, :photo => @attr
          flash[:notice].should =~ /success/i
        end
      end
      context 'as user' do
        login_user
        it 'should not create a photo' do
          lambda do
            post :create, :photo => @attr
          end.should_not change(Photo, :count).by(1)
        end
        it 'should redirect to login' do
          post :create, :photo => @attr
          response.should redirect_to login_path
        end
      end
      context 'as volunteer' do
        login_volunteer
        it 'should create a photo' do
          lambda do
            post :create, :photo => @attr
          end.should change(Photo, :count).by(1)
        end
        it 'should redirect to newly created photo' do
          post :create, :photo => @attr
          response.should redirect_to assigns[:photo]
        end
        it 'should have a success message' do
          post :create, :photo => @attr
          flash[:notice].should =~ /success/i
        end
      end
      context 'as staff' do
        login_staff
        it 'should create a photo' do
          lambda do
            post :create, :photo => @attr
          end.should change(Photo, :count).by(1)
        end
        it 'should redirect to newly created photo' do
          post :create, :photo => @attr
          response.should redirect_to assigns[:photo]
        end
        it 'should have a success message' do
          post :create, :photo => @attr
          flash[:notice].should =~ /success/i
        end
      end
    end
  end

  # PUT update
  describe "PUT 'update'" do
    context 'as guest' do
      before(:each) do
        @photo = Factory.create(:photo)
      end
      it 'should redirect to login path' do
        put :update, :id => @photo
        response.should redirect_to login_path
      end
    end
    describe 'should succeed' do
      before(:each) do
        @attr = {
          :photo => File.new(File.join(Rails.root, 'spec', 'support', 'test.png'))
        }
      end
      context 'as volunteer' do
        login_volunteer
        before(:each) do
          @photo = Factory.create(:photo, :user => @user)
        end
        it 'should change the photo attributes' do
          put :update, :id => @photo, :photo => @attr
          @photo.reload
          @photo.photo.url.should =~ /original/i
        end
        it 'should redirect to the photo' do
          put :update, :id => @photo, :photo => @attr
          flash[:notice].should =~ /success/i
          response.should redirect_to assigns[:photo]
        end
      end
      context 'as staff' do
        login_staff
        before(:each) do
          @photo = Factory.create(:photo, :user => @user)
        end
        it 'should change the photo attributes' do
          put :update, :id => @photo, :photo => @attr
          @photo.reload
          @photo.photo.url.should =~ /original/i
        end
        it 'should redirect to the photo' do
          put :update, :id => @photo, :photo => @attr
          flash[:notice].should =~ /success/i
          response.should redirect_to assigns[:photo]
        end
      end
    end
  end

  # DELETE destroy
  describe "DELETE 'destroy'" do
    context 'as admin' do
      login_admin
      before(:each) do
        @photo = Factory.create(:photo)
      end
      it 'should destroy the photo' do
        lambda do
          delete :destroy, :id => @photo
        end.should change(Photo, :count).by(-1)
      end
      it 'should redirect to photos path' do
        delete :destroy, :id => @photo
        response.should redirect_to photos_path
      end
    end
    context 'as guest' do
      before(:each) do
        @photo = Factory.create(:photo)
      end
      it 'should not destroy the photo' do
        lambda do
          delete :destroy, :id => @photo
        end.should_not change(Photo, :count).by(-1)
      end
      it 'should redirect to login path' do
        delete :destroy, :id => @photo
        response.should redirect_to login_path
      end
    end
    context 'as volunteer' do
      login_volunteer
      context 'non-owner' do
        before(:each) do
          @photo = Factory.create(:photo)
        end
        it 'should not destroy the photo' do
          lambda do
            delete :destroy, :id => @photo
          end.should_not change(Photo, :count).by(-1)
        end
        it 'should redirect to login path' do
          delete :destroy, :id => @photo
          response.should redirect_to login_path
        end
      end
      context 'owner' do
        before(:each) do
          @photo = Factory.create(:photo, :user => @user)
        end
        it 'should not destroy the photo' do
          lambda do
            delete :destroy, :id => @photo
          end.should_not change(Photo, :count).by(-1)
        end
        it 'should redirect to login' do
          delete :destroy, :id => @photo
          response.should redirect_to login_path
        end
      end
    end
  end
  
end

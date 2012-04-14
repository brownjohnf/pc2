require 'spec_helper'

describe DocumentsController do
  
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

  # GET table
  describe '#table' do
    context 'as anyone' do
      it 'should be successful' do
        get :table
        response.should be_success
      end
      it 'should have a table element' do
        get :table
        response.should have_selector('table')
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
      it 'should redirect to #index without a query present' do
        get :search
        response.should redirect_to documents_path
      end
    end
  end

  # GET show
  describe "GET 'show'" do
    before(:each) do
      @document = Factory.create(:document)
    end
    context 'as anyone' do
      it 'should be successful' do
        get :show, :id => @document
        response.should be_success
      end
      it 'should be the correct doc' do
        get :show, :id => @document
        assigns(:document).should == @document
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
        @document = Factory.create(:document)
      end
      it 'should redirect to login' do
        get :edit, :id => @document
        response.should redirect_to login_path
      end
    end
    context 'as a user' do
      login_user
      describe 'who is owner' do
        before(:each) do
          @document = Factory.create(:document, :user => @user)
        end
        it 'should not be successful' do
          get :edit, :id => @document
          response.should_not be_success
        end
        it 'should redirect to login' do
          get :edit, :id => @document
          response.should redirect_to login_path
        end
      end
      describe 'who is not owner' do
        before(:each) do
          @document = Factory.create(:document)
        end
        it 'should redirect to login' do
          get :edit, :id => @document
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
          :file => nil
        }
      end
      context 'as admin' do
        login_admin
        it 'should not create a document' do
          expect { post :create, :document => @attr }.to change(Document, :count).by(0)
        end
        it 'should render the new document form' do
          post :create, :document => @attr
          response.should render_template 'documents/new'
        end
      end
    end
    describe 'should be successful' do
      before(:each) do
        @attr = {
          :file => Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'test.txt'), 'text/plain')
        }
      end
      context 'as admin' do
        login_admin
        it 'should create a document' do
          lambda do
            post :create, :document => @attr
          end.should change(Document, :count).by(1)
        end
        it 'should redirect to newly created document' do
          post :create, :document => @attr
          response.should redirect_to assigns[:document]
        end
        it 'should have a success message' do
          post :create, :document => @attr
          flash[:notice].should =~ /success/i
        end
      end
      context 'as user' do
        login_user
        it 'should not create a document' do
          lambda do
            post :create, :document => @attr
          end.should_not change(Document, :count).by(1)
        end
        it 'should redirect to login' do
          post :create, :document => @attr
          response.should redirect_to login_path
        end
      end
      context 'as volunteer' do
        login_volunteer
        it 'should create a document' do
          lambda do
            post :create, :document => @attr
          end.should change(Document, :count).by(1)
        end
        it 'should redirect to newly created document' do
          post :create, :document => @attr
          response.should redirect_to assigns[:document]
        end
        it 'should have a success message' do
          post :create, :document => @attr
          flash[:notice].should =~ /success/i
        end
      end
      context 'as staff' do
        login_staff
        it 'should create a document' do
          lambda do
            post :create, :document => @attr
          end.should change(Document, :count).by(1)
        end
        it 'should redirect to newly created document' do
          post :create, :document => @attr
          response.should redirect_to assigns[:document]
        end
        it 'should have a success message' do
          post :create, :document => @attr
          flash[:notice].should =~ /success/i
        end
      end
    end
  end

  # PUT update
  describe "PUT 'update'" do
    context 'as guest' do
      before(:each) do
        @document = Factory.create(:document)
      end
      it 'should redirect to login path' do
        put :update, :id => @document
        response.should redirect_to login_path
      end
    end
    describe 'should fail without content' do
      before(:each) do
        @attr = {
          :file => nil,
          :name => 'new title'
        }
        @document = Factory.create(:document)
      end
      context 'as admin' do
        login_admin
        it 'should not render the edit view' do
          put :update, :id => @document, :document => @attr
          response.should render_template 'documents/edit'
        end
        it 'should not update the record' do
          put :update, :id => @document, :document => @attr
          @document.reload
          @document.name.should_not == @attr[:name]
        end
      end
    end
    describe 'with valid content' do
      before(:each) do
        @attr = {
          :file => File.new(File.join(Rails.root, 'spec', 'support', 'test.txt')),
          :name => 'new title'
        }
      end
      context 'as admin' do
        login_admin
        before(:each) do
          @document = Factory.create(:document)
        end
        it 'should change the document attributes' do
          put :update, :id => @document, :document => @attr
          @document.reload
          @document.name.should == @attr[:name]
        end
        it 'should redirect to the document' do
          put :update, :id => @document, :document => @attr
          flash[:notice].should =~ /success/i
          response.should redirect_to assigns[:document]
        end
      end
      context 'as volunteer owner' do
        login_volunteer
        before(:each) do
          @document = Factory.create(:document, :user => @user)
        end
        it 'should change the document attributes' do
          put :update, :id => @document, :document => @attr
          @document.reload
          @document.name.should == @attr[:name]
        end
        it 'should redirect to the document' do
          put :update, :id => @document, :document => @attr
          flash[:notice].should =~ /success/i
          response.should redirect_to assigns[:document]
        end
      end
      context 'as volunteer non-owner' do
        login_volunteer
        before(:each) do
          @document = Factory.create(:document)
        end
        it 'should not change the document attributes' do
          put :update, :id => @document, :document => @attr
          @document.reload
          @document.name.should_not == @attr[:name]
        end
        it 'should redirect to login' do
          put :update, :id => @document, :document => @attr
          response.should redirect_to login_path
        end
      end
      context 'as staff owner' do
        login_staff
        before(:each) do
          @document = Factory.create(:document, :user => @user)
        end
        it 'should change the document attributes' do
          put :update, :id => @document, :document => @attr
          @document.reload
          @document.name.should == @attr[:name]
        end
        it 'should redirect to the document' do
          put :update, :id => @document, :document => @attr
          flash[:notice].should =~ /success/i
          response.should redirect_to assigns[:document]
        end
      end
      context 'as staff non-owner' do
        login_staff
        before(:each) do
          @document = Factory.create(:document)
        end
        it 'should not change the document attributes' do
          put :update, :id => @document, :document => @attr
          @document.reload
          @document.name.should_not == @attr[:name]
        end
        it 'should redirect to login' do
          put :update, :id => @document, :document => @attr
          response.should redirect_to login_path
        end
      end
    end
  end

  # DELETE destroy
  describe "DELETE 'destroy'" do
    context 'as admin' do
      login_admin
      before(:each) do
        @document = Factory.create(:document)
      end
      it 'should destroy the document' do
        lambda do
          delete :destroy, :id => @document
        end.should change(Document, :count).by(-1)
      end
      it 'should redirect to #index' do
        delete :destroy, :id => @document
        response.should redirect_to documents_path
      end
    end
    context 'as guest' do
      before(:each) do
        @document = Factory.create(:document)
      end
      it 'should not destroy the doc' do
        lambda do
          delete :destroy, :id => @document
        end.should_not change(Document, :count).by(-1)
      end
      it 'should redirect to login path' do
        delete :destroy, :id => @document
        response.should redirect_to login_path
      end
    end
    context 'as volunteer' do
      login_volunteer
      context 'non-owner' do
        before(:each) do
          @document = Factory.create(:document)
        end
        it 'should not destroy the document' do
          lambda do
            delete :destroy, :id => @document
          end.should_not change(Document, :count).by(-1)
        end
        it 'should redirect to login path' do
          delete :destroy, :id => @document
          response.should redirect_to login_path
        end
      end
      context 'owner' do
        before(:each) do
          @document = Factory.create(:document, :user => @user)
        end
        it 'should not destroy the document' do
          lambda do
            delete :destroy, :id => @document
          end.should_not change(Document, :count).by(-1)
        end
        it 'should redirect to login' do
          delete :destroy, :id => @document
          response.should redirect_to login_path
        end
      end
    end
  end
  
end

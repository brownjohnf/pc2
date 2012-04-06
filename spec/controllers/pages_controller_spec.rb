require 'spec_helper'

describe PagesController do
  include Devise::TestHelpers
  
  render_views

  # GET index
  describe "GET 'index'" do
    context 'as anyone' do
      login_guest
      it 'should be successful' do
        get 'index'
        response.should be_success
      end
    end
  end

  # GET feed
  describe "GET 'feed'" do
    context 'as anyone' do
      login_guest
      it 'should be successful on atom request' do 
        get :feed, :format => 'atom'
        response.should be_success
      end
      it 'should fail on rss request' do
        get :feed, :format => 'rss'
        response.should redirect_to feed_pages_path(:format => 'atom')
      end
    end
  end

  # GET search
  describe "GET 'search'" do
    context 'as anyone' do
      login_guest
      it 'should be successful with a query present' do
        get :search, {:q => 'test'}
        response.should be_success
      end
      it 'should redirect without a query present' do
        get :search
        response.should redirect_to pages_path
      end
    end
  end

  # GET added
  describe "GET 'added'" do
    context 'as anyone' do
      login_guest
      it 'should be successful' do
        get 'added'
        response.should be_success
      end
    end
  end

  # GET updated
  describe "GET 'updated'" do
    context 'as anyone' do
      login_guest
      it 'should be successful' do
        get 'updated'
        response.should be_success
      end
    end
  end

  # GET show
  describe "GET 'show'" do
    before(:each) do
      @page = Factory.create(:page)
    end
    context 'as anyone' do
      login_guest
      it 'should be successful' do
        get 'show', :id => @page
        response.should be_success
      end
      it 'should be the correct page' do
        get :show, :id => @page
        assigns(:page).should == @page
      end
    end
  end
  
  # GET new
  describe "GET 'new'" do
    context 'as user' do
      login_user
      it 'should redirect to login' do
        get 'new'
        response.should redirect_to login_path
      end
    end
    context 'as volunteer' do
      login_volunteer
      it 'should be successful' do
        get 'new'
        response.should be_success
      end
    end
    context 'as staff' do
      login_staff
      it 'should be successful' do
        get 'new'
        response.should be_success
      end
    end
    context 'as guest' do
      login_guest
      it 'should redirect to login' do
        get 'new'
        response.should redirect_to login_path
      end
    end
  end

  # POST create
  describe "POST 'create'" do
    context 'as guest' do
      login_guest
      it 'should redirect to login' do
        post :create
        response.should redirect_to login_path
      end
    end
    describe 'no-content failure' do
      bad_page_attributes
      context 'as admin' do
        login_admin
        it 'should not create a new page' do
          lambda do
            post :create, :page => @attr
          end.should_not change(Page, :count).by(1)
        end
        it 'should render the new page form' do
          post :create, :page => @attr
          response.should render_template 'new'
        end
      end
    end
    describe 'success' do
      good_page_attributes
      context 'as volunteer' do
        login_volunteer
        it 'should create a page' do
          lambda do
            post :create, :page => @attr
          end.should change(Page, :count).by(1)
        end
        it 'should redirect to newly created page' do
          post :create, :page => @attr
          response.should redirect_to assigns[:page]
        end
        it 'should have a success message' do
          post :create, :page => @attr
          flash[:notice].should =~ /success/i
        end
      end
      context 'as staff' do
        login_staff
        it 'should create a page' do
          lambda do
            post :create, :page => @attr
          end.should change(Page, :count).by(1)
        end
        it 'should redirect to newly created page' do
          post :create, :page => @attr
          response.should redirect_to assigns[:page]
        end
        it 'should have a success message' do
          post :create, :page => @attr
          flash[:notice].should =~ /success/i
        end
      end
    end
  end

  # PUT update
  describe "PUT 'update'" do
    before(:each) do
      @page = Factory.create(:page)
    end
    describe 'without content' do
      bad_page_attributes
      context 'as admin' do
        login_admin
        it 'should render the edit page' do
          put :update, :id => @page, :page => @attr
          response.should render_template 'edit'
        end
      end
    end
    context 'with content' do
      good_page_attributes
      context 'as volunteer' do
        login_volunteer
        describe 'non-contributor' do
          it 'should redirect to login' do
            put :update, :id => @page, :page => @attr
            response.should redirect_to login_path
          end
        end
        describe 'contributor' do
          before(:each) do
            @page.contributions.build(:user_id => @user.id)
            @page.save!
          end
          it 'should change the page attributes' do
            put :update, :id => @page, :page => @attr
            @page.reload
            @page.title.should == @attr[:title]
            @page.description.should == @attr[:description]
            @page.content.should == @attr[:content]
            @page.language_id.should == @attr[:language_id]
          end
          it 'should redirect to page' do
            put 'update', {:id => @page.id, :page => @attr}
            flash[:notice].should =~ /success/i
            response.should redirect_to assigns[:page]
          end
        end
      end
      context 'as staff' do
        login_staff
        describe 'non-contributor' do
          it 'should redirect to login' do
            put :update, :id => @page, :page => @attr
            response.should redirect_to login_path
          end
        end
        describe 'contributor' do
          before(:each) do
            @page.contributions.build(:user_id => @user.id)
            @page.save!
          end
          it 'should change the page attributes' do
            put :update, :id => @page, :page => @attr
            @page.reload
            @page.title.should == @attr[:title]
            @page.description.should == @attr[:description]
            @page.content.should == @attr[:content]
            @page.language_id.should == @attr[:language_id]
          end
          it 'should redirect to page' do
            put 'update', {:id => @page.id, :page => @attr}
            flash[:notice].should =~ /success/i
            response.should redirect_to assigns[:page]
          end
        end
      end
      context 'as user' do
        login_user
        describe 'non-contributor' do
          it 'should redirect to login' do
            put :update, :id => @page, :page => @attr
            response.should redirect_to login_path
          end
        end
        describe 'contributor' do
          before(:each) do
            @page.contributions.build(:user_id => @user.id)
            @page.save!
          end
          it 'should not change the page attributes' do
            put :update, :id => @page, :page => @attr
            @page.reload
            @page.title.should_not == @attr[:title]
            @page.description.should_not == @attr[:description]
            @page.content.should_not == @attr[:content]
            @page.language_id.should_not == @attr[:language_id]
          end
          it 'should redirect to login' do
            put 'update', {:id => @page.id, :page => @attr}
            response.should redirect_to login_path
          end
        end
      end
      context 'as guest' do
        login_guest
        describe 'non-contributor' do
          it 'should redirect to login' do
            put :update, :id => @page, :page => @attr
            response.should redirect_to login_path
          end
        end
      end
    end
  end

  # POST mercury_update
  describe "POST 'mercury_update'" do
    before(:each) do
      @page = Factory.create(:page)
      @attr = {
        :page_content => {
          :value => 'new page content'
        }
      }
    end
    context 'as guest' do
      login_guest
      it 'should not change page attributes' do
        post :mercury_update, :id => @page, :content => @attr
        @page.reload
        @page.content.should_not == @attr[:page_content][:value]
      end
      it 'should redirect to login' do
        post :mercury_update, :id => @page, :content => @attr
        response.should redirect_to login_path
      end
    end
    context 'as volunteer' do
      login_volunteer
      context 'non-contributor' do
        it 'should not change page attributes' do
          post :mercury_update, :id => @page, :content => @attr
          @page.reload
          @page.content.should_not == @attr[:page_content][:value]
        end
        it 'should redirect to login' do
          post :mercury_update, :id => @page, :content => @attr
          response.should redirect_to login_path
        end
      end
      context 'contributor' do
        before(:each) do
          @page.contributions.build(:user_id => @user.id)
          @page.save!
        end
        it 'should be successful' do
          post :mercury_update, :id => @page, :content => @attr
          response.should be_success
        end
        it 'should change page attributes' do
          put :mercury_update, :id => @page, :content => @attr
          @page.reload
          @page.content.should == @attr[:page_content][:value]
        end
      end
    end
    context 'as staff' do
      login_staff
      context 'non-contributor' do
        it 'should not change page attributes' do
          post :mercury_update, :id => @page, :content => @attr
          @page.reload
          @page.content.should_not == @attr[:page_content][:value]
        end
        it 'should redirect to login' do
          post :mercury_update, :id => @page, :content => @attr
          response.should redirect_to login_path
        end
      end
      context 'contributor' do
        before(:each) do
          @page.contributions.build(:user_id => @user.id)
          @page.save!
        end
        it 'should be successful' do
          post :mercury_update, :id => @page, :content => @attr
          response.should be_success
        end
        it 'should change page attributes' do
          put :mercury_update, :id => @page, :content => @attr
          @page.reload
          @page.content.should == @attr[:page_content][:value]
        end
      end
    end
  end

  # DELETE destroy
  describe "DELETE 'destroy'" do
    before(:each) do
      @page = Factory.create(:page)
    end
    context 'as guest' do
      login_guest
      it 'should not destroy the page' do
        lambda do
          delete :destroy, :id => @page
        end.should_not change(Page, :count).by(-1)
      end
      it 'should redirect to login path' do
        delete :destroy, :id => @case_study
        response.should redirect_to login_path
      end
    end
    context 'as volunteer' do
      login_volunteer
      context 'non-contributor' do
        it 'should not destroy the page' do
          lambda do
            delete :destroy, :id => @page
          end.should_not change(Page, :count).by(-1)
        end
        it 'should redirect to login path' do
          delete :destroy, :id => @page
          response.should redirect_to login_path
        end
      end
      context 'contributor' do
        before(:each) do
          @page.contributions.build(:user_id => @user.id)
          @page.save!
        end
        it 'should destroy the page' do
          lambda do
            delete :destroy, :id => @page
          end.should change(Page, :count).by(-1)
        end
        it 'should redirect to pages index' do
          delete 'destroy', {:id => @page.id}
          response.should redirect_to pages_url
        end
      end
    end
    context 'as staff' do
      login_staff
      context 'non-contributor' do
        it 'should not destroy the page' do
          lambda do
            delete :destroy, :id => @page
          end.should_not change(Page, :count).by(-1)
        end
        it 'should redirect to login path' do
          delete :destroy, :id => @page
          response.should redirect_to login_path
        end
      end
      context 'contributor' do
        before(:each) do
          @page.contributions.build(:user_id => @user.id)
          @page.save!
        end
        it 'should destroy the page' do
          lambda do
            delete :destroy, :id => @page
          end.should change(Page, :count).by(-1)
        end
        it 'should redirect to pages index' do
          delete 'destroy', {:id => @page.id}
          response.should redirect_to pages_url
        end
      end
    end
    context 'as user' do
      login_user
      context 'non-contributor' do
        it 'should not destroy the page' do
          lambda do
            delete :destroy, :id => @page
          end.should_not change(Page, :count).by(-1)
        end
        it 'should redirect to login path' do
          delete :destroy, :id => @page
          response.should redirect_to login_path
        end
      end
      context 'contributor' do
        before(:each) do
          @page.contributions.build(:user_id => @user.id)
          @page.save!
        end
        it 'should not destroy the page' do
          lambda do
            delete :destroy, :id => @page
          end.should_not change(Page, :count).by(-1)
        end
        it 'should redirect to login' do
          delete 'destroy', {:id => @page.id}
          response.should redirect_to login_path
        end
      end
    end
  end

  describe "GET 'ajax'" do
    it 'should be successful' do
      get 'ajax'
      response.should be_success
    end
  end
  
end

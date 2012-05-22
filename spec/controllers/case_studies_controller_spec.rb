require 'spec_helper'

describe CaseStudiesController do
  
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
      it 'should redirect without a query present' do
        get :search
        response.should redirect_to case_studies_path
      end
    end
  end

  # GET added
  describe "GET 'added'" do
    context 'as anyone' do
      it 'should be successful' do
        get 'added'
        response.should be_success
      end
    end
  end

  # GET updated
  describe "GET 'updated'" do
    context 'as anyone' do
      it 'should be successful' do
        get 'updated'
        response.should be_success
      end
    end
  end

  # GET show
  describe "GET 'show'" do
    before(:each) do
      @case_study = Factory.create(:case_study)
    end
    context 'as anyone' do
      it 'should be successful' do
        get :show, :id => @case_study
        response.should be_success
      end
      it 'should be the correct case study' do
        get :show, :id => @case_study
        assigns(:case_study).should == @case_study
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
    before(:each) do
      @case_study = Factory(:case_study)
    end
    context 'as guest' do
      it 'should redirect to login' do
        get :edit, :id => @case_study
        response.should redirect_to login_path
      end
    end
    context 'as a user' do
      login_user
      describe 'who is a contributor' do
        before(:each) do
          @case_study.contributions.build(:user_id => @user.id)
        end
        it 'should redirect' do
          get :edit, :id => @case_study
          response.should redirect_to login_path
        end
      end
      describe 'who is not a contributor' do
        it 'should redirect to login' do
          get :edit, :id => @case_study
          response.should redirect_to login_path
        end
      end
    end
    context 'as volunteer' do
      login_volunteer
      describe 'with a case study' do
        before(:each) do
          @case_study = Factory.create(:case_study)
        end
        context 'as a contributor' do
          before(:each) do
            @case_study.contributions.build(:user_id => @user.id)
            @case_study.save!
          end
          it 'should be successful' do
            get :edit, :id => @case_study
            response.should be_success
          end
          it 'should have the correct data' do
            get :edit, :id => @case_study
            response.should have_selector('input', :id => 'case_study_title', :value => @case_study.title)
          end
        end
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
          :title => '',
          :summary => '',
          :country => '',
          :language_id => ''
        }
      end
      context 'as admin' do
        login_admin
        it 'should not create a case study' do
          lambda do
            post :create, :case_study => @attr
          end.should_not change(CaseStudy, :count).by(1)
        end
        it 'should render the new case study form' do
          post :create, :case_study => @attr
          response.should render_template 'case_studies/new'
        end
      end
    end
    describe 'should be successful' do
      before(:each) do
        @attr = {
          :title => 'Test Title',
          :summary => 'Test summary',
          :country => 'SN',
          :language_id => 1
        }
      end
      context 'as volunteer' do
        login_volunteer
        it 'should create a case study' do
          lambda do
            post :create, :case_study => @attr
          end.should change(CaseStudy, :count).by(1)
        end
        it 'should redirect to newly created case study' do
          post :create, :case_study => @attr
          response.should redirect_to assigns[:case_study]
        end
        it 'should have a success message' do
          post :create, :case_study => @attr
          flash[:notice].should =~ /success/i
        end
      end
      context 'as staff' do
        login_staff
        it 'should create a case study' do
          lambda do
            post :create, :case_study => @attr
          end.should change(CaseStudy, :count).by(1)
        end
        it 'should redirect to newly created case study' do
          post :create, :case_study => @attr
          response.should redirect_to assigns[:case_study]
        end
        it 'should have a success message' do
          post :create, :case_study => @attr
          flash[:notice].should =~ /success/i
        end
      end
    end
  end

  # PUT update
  describe "PUT 'update'" do
    before(:each) do
      @case_study = Factory.create(:case_study)
    end
    context 'as guest' do
      it 'should redirect to login path' do
        put :update, :id => @case_study
        response.should redirect_to login_path
      end
    end
    describe 'should fail' do
      before(:each) do
        @attr = {
          :title => '',
          :summary => '',
          :country => '',
          :language_id => ''
        }
      end
      context 'as admin' do
        login_admin
        it 'should render the edit page' do
          put :update, :id => @case_study, :case_study => @attr
          response.should render_template 'edit'
        end
      end
    end
    describe 'should succeed' do
      before(:each) do
        @case_study = Factory.create(:case_study)
        @attr = {
          :title => 'Test Title',
          :summary => 'Test summary.',
          :country => 'SN',
          :language_id => 2
        }
      end
      context 'as volunteer' do
        login_volunteer
        before(:each) do
          @case_study.contributions.build(:user_id => @user.id)
          @case_study.save!
        end
        it 'should change the case study attributes' do
          put 'update', :id => @case_study, :case_study => @attr
          @case_study.reload
          @case_study.title.should == @attr[:title]
          @case_study.summary.should == @attr[:summary]
          @case_study.country.should == @attr[:country]
          @case_study.language_id.should == @attr[:language_id]
        end
        it 'should redirect to show case study' do
          put :update, :id => @case_study, :case_study => @attr
          flash[:notice].should =~ /success/i
          response.should redirect_to assigns[:case_study]
        end
      end
      context 'as staff' do
        login_staff
        before(:each) do
          @case_study.contributions.build(:user_id => @user.id)
          @case_study.save!
        end
        it 'should change the case study attributes' do
          put 'update', :id => @case_study, :case_study => @attr
          @case_study.reload
          @case_study.title.should == @attr[:title]
          @case_study.summary.should == @attr[:summary]
          @case_study.country.should == @attr[:country]
          @case_study.language_id.should == @attr[:language_id]
        end
        it 'should redirect to show case study' do
          put :update, :id => @case_study, :case_study => @attr
          flash[:notice].should =~ /success/i
          response.should redirect_to assigns[:case_study]
        end
      end
    end
  end

  # POST mercury_update
  describe "POST 'mercury_update'" do
    before(:each) do
      @case_study = Factory.create(:case_study)
      @attr = {
        :cs_summary => { :value => 'new case study summary' },
        :cs_context => { :value => 'new case study context' },
        :cs_approach => { :value => 'new case study approach' },
        :cs_results => { :value => 'new case study results' },
        :cs_challenges => { :value => 'new case study challenges' },
        :cs_lessons => { :value => 'new case study lessons learned' },
        :cs_steps => { :value => 'new case study next steps' }
      }
    end
    context 'as guest' do
      it 'should not change case study attributes' do
        post :mercury_update, :id => @case_study, :content => @attr
        @case_study.reload
        @case_study.summary.should_not == @attr[:cs_summary][:value]
      end
      it 'should redirect to login' do
        post :mercury_update, :id => @case_study, :content => @attr
        response.should redirect_to login_path
      end
    end
    context 'as volunteer' do
      login_volunteer
      context 'non-contributor' do
        it 'should not change case study attributes' do
          post :mercury_update, :id => @case_study, :content => @attr
          @case_study.reload
          @case_study.summary.should_not == @attr[:cs_summary][:value]
        end
        it 'should redirect to login' do
          post :mercury_update, :id => @case_study, :content => @attr
          response.should redirect_to login_path
        end
      end
      context 'contributor' do
        before(:each) do
          @case_study.contributions.build(:user_id => @user.id)
          @case_study.save!
        end
        it 'should be successful' do
          post :mercury_update, :id => @case_study, :content => @attr
          response.should be_success
        end
        it 'should change the case study attributes' do
          put :mercury_update, :id => @case_study, :content => @attr
          @case_study.reload
          @case_study.summary.should == @attr[:cs_summary][:value]
        end
      end
    end
    context 'as staff' do
      login_staff
      context 'non-contributor' do
        it 'should not change case study attributes' do
          post :mercury_update, :id => @case_study, :content => @attr
          @case_study.reload
          @case_study.summary.should_not == @attr[:cs_summary][:value]
        end
        it 'should redirect to login' do
          post :mercury_update, :id => @case_study, :content => @attr
          response.should redirect_to login_path
        end
      end
      context 'contributor' do
        before(:each) do
          @case_study.contributions.build(:user_id => @user.id)
          @case_study.save!
        end
        it 'should be successful' do
          post :mercury_update, :id => @case_study, :content => @attr
          response.should be_success
        end
        it 'should change the case study attributes' do
          put :mercury_update, :id => @case_study, :content => @attr
          @case_study.reload
          @case_study.summary.should == @attr[:cs_summary][:value]
        end
      end
    end
  end

  # DELETE destroy
  describe "DELETE 'destroy'" do
    before(:each) do
      @case_study = Factory.create(:case_study)
    end
    context 'as guest' do
      it 'should not destroy the case study' do
        lambda do
          delete :destroy, :id => @case_study
        end.should_not change(CaseStudy, :count).by(-1)
      end
      it 'should redirect to login path' do
        delete :destroy, :id => @case_study
        response.should redirect_to login_path
      end
    end
    context 'as volunteer' do
      login_volunteer
      context 'non-contributor' do
        it 'should not destroy the case study' do
          lambda do
            delete :destroy, :id => @case_study
          end.should_not change(CaseStudy, :count).by(-1)
        end
        it 'should redirect to login path' do
          delete :destroy, :id => @case_study
          response.should redirect_to login_path
        end
      end
      context 'contributor' do
        before(:each) do
          @case_study.contributions.build(:user_id => @user.id)
          @case_study.save!
        end
        it 'should not destroy the case study' do
          lambda do
            delete :destroy, :id => @case_study
          end.should_not change(CaseStudy, :count).by(-1)
        end
        it 'should redirect to case studies index' do
          delete :destroy, :id => @case_study
          response.should redirect_to login_path
        end
      end
    end
    context 'as staff' do
      login_staff
      context 'non-contributor' do
        it 'should not destroy the case study' do
          lambda do
            delete :destroy, :id => @case_study
          end.should_not change(CaseStudy, :count).by(-1)
        end
        it 'should redirect to login path' do
          delete :destroy, :id => @case_study
          response.should redirect_to login_path
        end
      end
      context 'contributor' do
        before(:each) do
          @case_study.contributions.build(:user_id => @user.id)
          @case_study.save!
        end
        it 'should not destroy the case study' do
          lambda do
            delete :destroy, :id => @case_study
          end.should_not change(CaseStudy, :count).by(-1)
        end
        it 'should redirect to case studies index' do
          delete :destroy, :id => @case_study
          response.should redirect_to login_path
        end
      end
    end
    context 'as user' do
      login_user
      context 'non-contributor' do
        it 'should not destroy the case study' do
          lambda do
            delete :destroy, :id => @case_study
          end.should_not change(CaseStudy, :count).by(-1)
        end
        it 'should redirect to login path' do
          delete :destroy, :id => @case_study
          response.should redirect_to login_path
        end
      end
      context 'contributor' do
        before(:each) do
          @case_study.contributions.build(:user_id => @user.id)
          @case_study.save!
        end
        it 'should not destroy the case study' do
          lambda do
            delete :destroy, :id => @case_study
          end.should_not change(CaseStudy, :count).by(-1)
        end
        it 'should redirect to login' do
          delete :destroy, :id => @case_study
          response.should redirect_to login_path
        end
      end
    end
  end
  
end

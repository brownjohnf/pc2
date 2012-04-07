require 'spec_helper'
require 'cancan/matchers'

describe User do
  describe 'abilities' do
    #subject { ability }
    #let(:ability){ Ability.new(user) }

    context 'a guest' do
      before(:each) do
        @ability = Ability.new(User.new)
      end

      describe 'pages' do
        it 'should be able to read' do
          @ability.should be_able_to(:read, Page)
        end
        it 'should not be able to create' do
          @ability.should_not be_able_to(:create, Page)
        end
        it 'should not be able to mercury update' do
          @ability.should_not be_able_to :mercury_update, Page
        end
      end
      
      it 'should be able to read case studies' do
        @ability.should be_able_to(:read, CaseStudy)
      end
      it 'should be able to read photos' do
        @ability.should be_able_to(:read, Photo)
      end
      it 'should be able to read websites' do
        @ability.should be_able_to(:read, Website)
      end
      it 'should be able to read blogs' do
        @ability.should be_able_to(:read, Blog)
      end
      it 'should be able to read libraries' do
        @ability.should be_able_to(:read, Library)
      end
      it 'should be able to read timeline moments' do
        @ability.should be_able_to(:read, Moment)
      end
      it 'should be able to read peace corps regions' do
        @ability.should be_able_to(:read, Pcregion)
      end
      it 'should be able to read positions' do
        @ability.should be_able_to(:read, Position)
      end
      it 'should be able to read sectors' do
        @ability.should be_able_to(:read, Sector)
      end
      describe 'staff' do
        it 'should be able to index staff' do
          @ability.should be_able_to(:index, Staff)
        end
        it 'should be able to show staff' do
          @ability.should be_able_to(:show, Staff)
        end
      end
      it 'should be able to read stages' do
        @ability.should be_able_to(:read, Stage)
      end
      it 'should not be able to read abilities' do
        @ability.should_not be_able_to(:read, Ability)
      end
      it 'should not be able to read authorizations' do
        @ability.should_not be_able_to(:read, Authorization)
      end
      it 'should not be able to read contributions' do
        @ability.should_not be_able_to(:read, Contribution)
      end
      it 'should not be able to read feedback' do
        @ability.should_not be_able_to(:read, Feedback)
      end
      it 'should not be able to read imports' do
        @ability.should_not be_able_to(:read, Import)
      end
      it 'should not be able to read jobs' do
        @ability.should_not be_able_to(:read, Job)
      end
      it 'should not be able to read region types' do
        @ability.should_not be_able_to(:read, Regiontype)
      end
      it 'should not be able to read roles' do
        @ability.should_not be_able_to(:read, Role)
      end
      it 'should not be able to read scopes' do
        @ability.should_not be_able_to(:read, Scope)
      end
      it 'should not be able to read sites' do
        @ability.should_not be_able_to(:read, Site)
      end
      it 'should not be able to read stacks' do
        @ability.should_not be_able_to(:read, Stack)
      end
      describe 'users' do
        it 'should be able to index' do
          @ability.should be_able_to :index, User
        end
        it 'should not be able to show' do
          @ability.should_not be_able_to :show, Factory(:user)
        end
        it 'should not be able to new' do
          @ability.should_not be_able_to :new, User
        end
        it 'should not be able to create' do
          @ability.should_not be_able_to :create, User
        end
        it 'should not be able to edit' do
          @ability.should_not be_able_to :edit, User
        end
        it 'should not be able to update' do
          @ability.should_not be_able_to :update, User
        end
        it 'should not be able to destroy' do
          @ability.should_not be_able_to :destroy, User
        end
      end
      describe 'volunteers' do
        it 'should not be able to index volunteers' do
          @ability.should be_able_to :index, Volunteer
        end
        it 'should not be able to show volunteers' do
          @ability.should_not be_able_to :show, Volunteer
        end
      end
    end

    context 'when it is a user' do
      before(:each) do
        @user = Factory(:user)
        @user.roles << Role.find_or_create_by_name('User')
        @ability = Ability.new(@user)
      end

      describe 'pages' do
        it 'should be able to index' do
          @ability.should be_able_to :index, Page
        end
        it 'should be able to show' do
          @ability.should be_able_to :show, Page
        end
        it 'should not be able to create' do
          @ability.should_not be_able_to :create, Page
        end
      end

      #let(:user){ Factory(:user) }
      
      #it{ should be_able_to(:read, Page) }
      #it{ should be_able_to(:read, User) }
      #it{ should be_able_to(:read, CaseStudy) }
      #it{ should be_able_to(:destroy, Setting) }
    end

    context 'when it is a volunteer' do
      before(:each) do
        @user = Factory(:user)
        @user.roles << Role.find_or_create_by_name('Volunteer')
        @ability = Ability.new(@user)
      end

      describe 'pages' do
        it 'should be able to create pages' do
          @ability.should be_able_to :create, Page
        end
        it 'should be able to edit contributed' do
          @page = Factory.create(:page)
          @page.contributions.build(:user_id => @user.id)
          @page.save!
          @ability.should be_able_to :update, @page
        end
      end
    end

    context 'when it is an admin' do
      before(:each) do
        @user = Factory(:user)
        @user.roles << Role.find_or_create_by_name('Admin')
        @ability = Ability.new(@user)
      end
      it 'should be able to manage all' do
        @ability.should be_able_to(:manage, :all)
      end
    end

  end
end

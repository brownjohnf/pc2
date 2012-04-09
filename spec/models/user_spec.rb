require 'spec_helper'
require 'cancan/matchers'

describe User do

  # model
  describe 'validation' do
    before(:each) do
      @attr = {
        :name => Factory.next(:name),
        :email => Factory.next(:email),
        :password => 'testing'
      }
    end
    it 'should create a new user given valid attributes' do
      User.create!(@attr)
    end
    it 'should require a name' do
      no_name_user = User.new(@attr.merge(:name => ''))
      no_name_user.should_not be_valid
    end
    it 'should require an email' do
      no_email_user = User.new(@attr.merge(:email => ''))
      no_email_user.should_not be_valid
    end
    it "should reject names that are too short" do
      short_name = "a" * 4
      short_name_user = User.new(@attr.merge(:name => short_name))
      short_name_user.should_not be_valid
    end
    it "should reject names that are too long" do
      long_name = "a" * 129
      long_name_user = User.new(@attr.merge(:name => long_name))
      long_name_user.should_not be_valid
    end
    it "should accept valid email addresses" do
      addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
      addresses.each do |address|
        valid_email_user = User.new(@attr.merge(:email => address))
        valid_email_user.should be_valid
      end
    end
    it "should reject invalid email addresses" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo. test@foo]
      addresses.each do |address|
        invalid_email_user = User.new(@attr.merge(:email => address))
        invalid_email_user.should_not be_valid
      end
    end
    it "should reject duplicate email addresses" do
      # put a user with a given email address into the database.
      User.create!(@attr)
      user_with_duplicate_email = User.new(@attr)
      user_with_duplicate_email.should_not be_valid
    end
    it "should reject email addresses identical up to case" do
      upcased_email = @attr[:email].upcase
      User.create!(@attr.merge(:email => upcased_email))
      user_with_duplicate_email = User.new(@attr)
      user_with_duplicate_email.should_not be_valid
    end

    describe 'password validations' do
      it "should require a password" do
        User.new(@attr.merge(:password => '')).should_not be_valid
      end
      it "should require a matching password confirmation" do
        User.new(@attr.merge(:password_confirmation => 'invalid')).should_not be_valid
      end
      it "should reject short passwords" do
        short = 'a' * 5
        hash = @attr.merge(:password => short)
        User.new(hash).should_not be_valid
      end
      it "should reject long passwords" do
        long = 'a' * 129
        hash = @attr.merge(:password => long)
        User.new(hash).should_not be_valid
      end
    end
  end

  # properties
  describe 'properties' do
    build_user
    it 'should have a canonical title' do
      @user.should respond_to(:canonical_title)
    end
    it 'should have an avatar attribute' do
      @user.should respond_to :avatar
    end
    describe 'with an avatar' do
      before(:each) do
        @user = Factory.create(:user, :avatar => File.new(File.join(Rails.root, 'spec', 'support', 'test.png')))
      end
      it 'should have an avatar' do
        @user.avatar_file_name.should == 'test.png'
      end
      it 'should be able to remove the avatar' do
        @user.avatar = nil
        @user.save
        @user.reload
        @user.avatar_file_name.should be_nil
      end
    end
  end

  # associations
  describe 'associations' do
    build_user
    describe 'roles' do
      it 'should have a roles attribute' do
        @user.should respond_to(:roles)
      end
      it "should have a 'User' role" do
        @user.roles.include?(Role.find_by_name('User')).should be_true
      end
      it 'should not destroy roles' do
        @user.destroy
        Role.find_by_name('User').should_not be_nil
      end
    end
    describe 'volunteers' do
      build_user_volunteers
      before(:each) do
        @volunteer2 = Factory.create(:volunteer, :cos_date => Time.now.end_of_year, :user => @user)
        @volunteer3 = Factory.create(:volunteer, :cos_date => Time.now.beginning_of_year, :user => @user)
      end
      it 'should have a volunteers attribute' do
        @user.should respond_to(:volunteers)
      end
      it 'should return the right volunteers in the right order' do
        @user.volunteers.should == [@volunteer2, @volunteer, @volunteer3]
      end
      it 'should destroy associated volunteers' do
        @user.destroy
        [@volunteer, @volunteer2, @volunteer3].each do |volunteer|
          Volunteer.find_by_id(volunteer.id).should be_nil
        end
      end
    end
    describe 'staff' do
      build_user_staff
      before(:each) do
        @staff2 = Factory.create(:staff, :user => @user)
      end
      it 'should have a staff attribute' do
        @user.should respond_to(:staff)
      end
      it 'should return the correct staff members' do
        @user.staff.include?(@staff).should be_true
        @user.staff.include?(@staff2).should be_true
      end
      it 'should destroy associated staff members' do
        @user.destroy
        [@staff, @staff2].each do |staff|
          Staff.find_by_id(staff.id).should be_nil
        end
      end
    end
    describe 'moments' do
      build_user_moments
      before(:each) do
        @moment2 = Factory.create(:moment, :datapoint => Time.now.end_of_year, :user => @user)
        @moment3 = Factory.create(:moment, :datapoint => Time.now.beginning_of_year, :user => @user)
      end
      it 'should have a moments attribute' do
        @user.should respond_to(:moments)
      end
      it 'should return the right moments in the right order' do
        @user.moments.should == [@moment2, @moment, @moment3]
      end
      it 'should destroy associated moments' do
        @user.destroy
        [@moment, @moment2, @moment3].each do |moment|
          Moment.find_by_id(moment.id).should be_nil
        end
      end
    end
    describe 'blogs' do
      build_user_blogs
      it 'should have a blogs attribute' do
        @user.should respond_to(:blogs)
      end
      it 'should return the correct blog' do
        @user.blogs.should == [@blog]
      end
      it 'should destroy associated blogs' do
        @user.destroy
        Blog.find_by_id(@blog.id).should be_nil
      end
    end
    describe 'libraries' do
      build_user_libraries
      it 'should have a libraries attribute' do
        @user.should respond_to(:libraries)
      end
      it 'should return the correct library' do
        @user.libraries.should == [@library]
      end
      it 'should destroy associated libraries' do
        @user.destroy
        Library.find_by_id(@library.id).should be_nil
      end
    end
    describe 'sites' do
      build_user_sites
      it 'should have a sites attribute' do
        @user.should respond_to(:sites)
      end
      it 'should return the correct site' do
        @user.sites.should == [@site]
      end
      it 'should not destroy associated sites' do
        @user.destroy
        Site.find_by_id(@site.id).should_not be_nil
      end
    end
    describe 'websites' do
      build_user_websites
      it 'should have a websites attribute' do
        @user.should respond_to(:websites)
      end
      it 'should return the correct website' do
        @user.websites.should == [@website]
      end
      it 'should not destroy associated websites' do
        @user.destroy
        Website.find_by_id(@website.id).should_not be_nil
      end
    end
    describe 'added_stacks' do
      build_user_added_stacks
      it 'should respond to stacks attribute' do
        @user.should respond_to :added_stacks
      end
      it 'should have an associated library' do
        @user.added_stacks.find_by_id(@stack.id).library.should == @library
      end
    end
    describe 'stacks' do
      build_user_stacks
      it 'should respond to stacks attribute' do
        @user.should respond_to :stacks
      end
      it 'should return the correct stack' do
        @user.stacks.should == [@stack]
      end
      it 'should return an associated user' do
        @user.stacks.find_by_id(@stack.id).user.should == @user2
      end
      it 'should return an associated library' do
        @user.stacks.find_by_id(@stack.id).library == @library
      end
      it 'should destroy associated stacks' do
        @user.destroy
        Stack.find_by_id(@stack.id).should be_nil
      end
    end
    describe 'documents' do
      build_user_documents
      it 'should respond to documents attribute' do
        @user.should respond_to :documents
      end
      it 'should return the correct document' do
        @user.documents.should == [@document]
      end
      it 'should not destroy associated docs' do
        @user.destroy
        Document.find_by_id(@document.id).should_not be_nil
      end
    end
    describe 'photos' do
      build_user_photos
      it 'should respond to photos attribute' do
        @user.should respond_to :photos
      end
      it 'should return the correct photo' do
        @user.photos.should == [@photo]
      end
      it 'should not destroy associated photos' do
        @user.destroy
        Photo.find_by_id(@photo.id).should_not be_nil
      end
    end
    describe 'contributions' do
      build_user_contributions
      it 'should respond to contributions attribute' do
        @user.should respond_to :contributions
      end
      it 'should return an associated contributed object' do
        @user.contributions.find_by_id(@contribution.id).contributable.should == @page
      end
      it 'should destroy associated contribution records' do
        @user.destroy
        Contribution.find_by_id(@contribution.id).should be_nil
      end
    end
    describe 'photo' do
      build_user_photo
      it 'should respond to photo attribute' do
        @user.should respond_to :photo
      end
      it 'should return the correct photo' do
        @user.photo.should == @photo
      end
      it 'should not destroy associated photo' do
        @user.destroy
        Photo.find_by_id(@photo.id).should_not be_nil
      end
    end
  end

  # abilities
  describe 'abilities' do
    #subject { ability }
    #let(:ability){ Ability.new(user) }

    context 'as a guest' do
      before(:each) do
        @ability = Ability.new(User.new)
      end

      describe 'pages' do
        build_page
        it 'should be able to read' do
          @ability.should be_able_to(:read, Page)
        end
        it 'should not be able to create' do
          @ability.should_not be_able_to(:create, Page)
        end
        it 'should not be able to update' do
          @ability.should_not be_able_to :update, @page
        end
      end
      
      describe 'case studies' do
        build_case_study
        it 'can be read' do
          @ability.should be_able_to(:read, CaseStudy)
        end
        it 'cannot be created' do
          @ability.should_not be_able_to :create, CaseStudy
        end
        it 'cannot update' do
          @ability.should_not be_able_to :update, @case_study
        end
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

      describe 'moments' do
        it 'can read' do
          @ability.should be_able_to(:read, Moment)
        end
        it 'cannot edit' do
          @ability.should_not be_able_to :edit, Moment
        end
      end

      it 'should be able to read peace corps regions' do
        @ability.should be_able_to(:read, PcRegion)
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
        it 'cannnot show' do
          @ability.should_not be_able_to(:show, Staff)
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
        it 'should be able to show' do
          @ability.should be_able_to :show, Factory(:user)
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
        build_volunteer
        it 'can index' do
          @ability.should be_able_to :index, Volunteer
        end
        it 'cannot show' do
          @ability.should_not be_able_to :show, @volunteer
        end
      end
    end

    context 'as a user' do
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

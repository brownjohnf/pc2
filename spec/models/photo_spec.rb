require 'spec_helper'

describe Photo do
  before(:each) do
    @user = Factory(:user)
    @attr = {
      :photo => File.open(File.join(Rails.root, 'spec', 'fixtures', 'test.png')),
      :imageable_id => @user.id,
      :imageable_type => 'User'
    }
  end

  it 'should create a new photo given valid attributes' do
    @user.photos.create!(@attr)
  end

  # validation
  describe 'validation' do
    it 'should require a user_id' do
      Photo.new(@attr.merge(:user_id => '')).should_not be_valid
    end
    it 'should require an imageable_type' do
      @user.photos.build(@attr.merge(:imageable_type => '')).should_not be_valid
    end
    it 'should require an imageable_id' do
      @user.photos.build(@attr.merge(:imageable_id => '')).should_not be_valid
    end
    it 'should require a photo' do
      @user.photos.build(@attr.merge(:photo => '')).should_not be_valid
    end
    it 'should require a fingerprint' do
      @user.photos.build(@attr.merge(:photo_fingerprint => nil)).should_not be_valid
    end
    it 'should require file uniqueness' do
      @photo1 = @user.photos.create(@attr).should be_valid
      @user.photos.build(@attr).should_not be_valid
    end
    it { should have_attached_file(:photo) }
    it { should validate_attachment_presence(:photo) }
    it { should validate_attachment_content_type(:photo).
      allowing('image/png', 'image/jpeg', 'image/gif') }
    it { should_not validate_attachment_size(:photo) }
    it 'should create a title if missing' do
      missing_title = @user.photos.new(@attr)
      missing_title.should be_valid
    end
    it 'should allow a custom title' do
      title = 'this is a custom title'
      photo = @user.photos.create(@attr.merge(:title => title))
      photo.title.should == title
    end
    it 'should set the photo info' do
      photo = @user.photos.create(@attr)
      photo.photo_file_name.should_not be_nil
      photo.photo_content_type.should_not be_nil
      photo.photo_file_size.should_not be_nil
      photo.photo_updated_at.should_not be_nil
      photo.photo_fingerprint.should_not be_nil
      photo.photo.url.should =~ /original\//i
    end
    it 'should reject descriptions longer than 255 chars' do
      @user.photos.build(@attr.merge(:description => 'a'*256)).should_not be_valid
    end
    it 'should accept tags' do
      tags = 'one,two'
      @photo = @user.photos.create(@attr.merge(:tag_list => tags))
      @photo.tag_list.should == tags.split(',')
    end
  end

  # properties
  describe 'properties' do
    build_photo
    it 'should set the canonical title in the address' do
      @photo.should respond_to(:to_param)
      @photo.to_param.should == "#{@photo.id}-#{@photo.canonical_title.parameterize}"
    end
  end

  # associations
  describe 'association' do
    # has_many users
    describe 'users' do
      before(:each) do
        @user = Factory.create(:user, :photo => @photo = Factory.create(:photo))
      end
      it 'should have a users attribute' do
        @photo.should respond_to(:users)
      end
      it 'should return the correct users' do
        @photo.users.should == [@user]
      end
      it 'should not destroy users' do
        @photo.destroy
        User.find_by_id(@user.id).should_not be_nil
      end
      it 'should reset user pointers' do
        @photo.destroy
        @user.reload
        @user.photo_id.should be_nil
      end
    end
    describe 'has_many pages' do
      before(:each) do
        @page = Factory.create(:page, :photo => @photo = Factory.create(:photo))
      end
      it 'should have a pages attribute' do
        @photo.should respond_to(:pages)
      end
      it 'should return the correct pages' do
        @photo.pages.should == [@page]
      end
      it 'should not destroy pages' do
        @photo.destroy
        Page.find_by_id(@page.id).should_not be_nil
      end
      it 'should reset page pointers' do
        @photo.destroy
        @page.reload
        @page.photo_id.should be_nil
      end
    end
    describe 'has_many moments' do
      before(:each) do
        @moment = Factory.create(:moment, :photo => @photo = Factory.create(:photo))
      end
      it 'should have a moments attribute' do
        @photo.should respond_to(:moments)
      end
      it 'should return the correct moments' do
        @photo.moments.should == [@moment]
      end
      it 'should not destroy moments' do
        @photo.destroy
        Moment.find_by_id(@moment.id).should_not be_nil
      end
      it 'should reset moment pointers' do
        @moment = Factory.create(:moment, :photo => @photo)
        @photo.destroy
        @moment.reload
        @moment.photo_id.should be_nil
      end
    end
    describe 'has_many case studies' do
      before(:each) do
        @case_study = Factory.create(:case_study, :photo => @photo = Factory.create(:photo))
      end
      it 'should have a case_studies attribute' do
        @photo.should respond_to(:case_studies)
      end
      it 'should return the correct case_studies' do
        @photo.case_studies.should == [@case_study]
      end
      it 'should not destroy case_studies' do
        @photo.destroy
        CaseStudy.find_by_id(@case_study.id).should_not be_nil
      end
      it 'should reset case study pointers' do
        @case_study = Factory.create(:case_study, :photo => @photo)
        @photo.destroy
        @case_study.reload
        @case_study.photo_id.should be_nil
      end
    end
    describe 'has_many stacks' do
      before(:each) do
        @stack = Factory.create(:stack, :stackable => @photo = Factory.create(:photo))
      end
      it 'should have a stacks attribute' do
        @photo.should respond_to(:stacks)
      end
      it 'should return the correct stack' do
        @photo.stacks.should == [@stack]
      end
      it 'should destroy stacks' do
        @photo.destroy
        Stack.find_by_id(@stack.id).should be_nil
      end
    end
    describe 'has_many libraries' do
      before(:each) do
        Factory.create(:stack, :library => @library = Factory.create(:library), :stackable => @photo = Factory.create(:photo))
      end
      it 'should have a stacks attribute' do
        @photo.should respond_to(:libraries)
      end
      it 'should return the correct library' do
        @photo.libraries.should == [@library]
      end
      it 'should not destroy libraries' do
        @photo.destroy
        Library.find_by_id(@library.id).should_not be_nil
      end
    end
    describe 'belongs_to imageable' do
      build_photo
      it 'should respond to imageable attribute' do
        @photo.should respond_to :imageable
      end
      it 'should not destroy associated imageable' do
        @class = @photo.imageable.class
        @id = @photo.imageable.id
        @photo.destroy
        @class.find_by_id(@id).should_not be_nil
      end
    end
    describe 'belongs_to user' do
      before(:each) do
        @photo = Factory.create(:photo, :user => @user = Factory.create(:user))
      end
      it 'should respond to user attribute' do
        @photo.should respond_to :user
      end
      it 'should return the correct user' do
        @photo.user.should == @user
      end
      it 'should not destroy associated user' do
        @photo.destroy
        User.find_by_id(@user.id).should_not be_nil
      end
    end
  end
end


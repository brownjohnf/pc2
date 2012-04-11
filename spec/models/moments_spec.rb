require 'spec_helper'

describe Moment do
  before(:each) do
    @user = Factory(:user)
    @attr = {
      :title => 'valid title',
      :summary => 'valid summary',
      :datapoint => Time.now.to_date
    }
  end

  it 'should create a new moment given valid attributes' do
    @user.moments.create!(@attr)
  end

  # validation
  describe 'validation' do
    it 'should require a user' do
      Moment.new(@attr).should_not be_valid
    end
    it 'should require a title' do
      bad = @user.moments.new(@attr.merge(:title => ''))
      bad.should_not be_valid
    end
    it 'should require a summary' do
      bad = @user.moments.new(@attr.merge(:summary => ''))
      bad.should_not be_valid
    end
    it 'should require a datapoint' do
      bad = @user.moments.new(@attr.merge(:datapoint => nil))
      bad.should_not be_valid
    end
  end

  # properties
  describe 'properties' do
    build_moment
    it 'should set the title in the address' do
      @moment.should respond_to(:to_param)
      @moment.to_param.should == "#{@moment.id}-#{@moment.title.parameterize}"
    end
    it 'should have a random attribute' do
      Moment.should respond_to :random
    end
    it 'should return the only moment on random if there is only one moment' do
      Moment.random.should == @moment
    end
    it 'should set the country to the user country if nil' do
      @moment.country.should == @user.country
    end
    it 'should change the country' do
      @moment.country = 'GM'
      @moment.save!
      @moment.country.should_not == @user.country
    end
    describe 'text content' do
      it 'should respond to text' do
        @moment.should respond_to :text
      end
      it 'should not be nil' do
        @moment.text.should_not be_nil
      end
      it 'should not be nil without photo' do
        @moment.photo = nil
        @moment.text.should_not be_nil
      end
      it 'should not be nil without content' do
        @moment.content = nil
        @moment.text.should_not be_nil
      end
    end
    describe 'media' do
      it 'should respond to media' do
        @moment.should respond_to :media
      end
      it 'should not be nil' do
        @moment.media.should_not be_nil
      end
      it 'should not be nil without photo' do
        @moment.photo = nil
        @moment.media.should_not be_nil
      end
      it 'should not be nil without content' do
        @moment.content = nil
        @moment.media.should_not be nil
      end
    end
    describe 'credit' do
      it 'should respond to credit' do
        @moment.should respond_to :credit
      end
      it 'should not be nil' do
        @moment.credit.should_not be_nil
      end
      it 'should not be nil without photo' do
        @moment.photo = nil
        @moment.credit.should_not be_nil
      end
    end
    describe 'caption' do
      it 'should respond to caption' do
        @moment.should respond_to :caption
      end
      it 'should not be nil' do
        @moment.caption.should_not be_nil
      end
      it 'should not be nil without photo' do
        @moment.photo = nil
        @moment.caption.should_not be_nil
      end
    end
  end

  # associations
  describe 'associations' do
    build_moment
    describe 'photos' do
      build_moment_photos
      it 'should have a photos attribute' do
        @moment.should respond_to(:photos)
      end
      it 'should return the correct photos' do
        @moment.photos.should == [@photo]
      end
      it 'should not destroy photos' do
        @moment.destroy
        Photo.find_by_id(@photo.id).should_not be_nil
      end
    end
    describe 'photo' do
      build_moment_photo
      it 'should respond to photo attribute' do
        @moment.should respond_to :photo
      end
      it 'should return the correct photo' do
        @moment.photo.should == @photo
      end
      it 'should not destroy associated photo' do
        @moment.destroy
        Photo.find_by_id(@photo.id).should_not be_nil
      end
    end
    describe 'user' do
      build_user_moments
      it 'should respond to user attribute' do
        @moment.should respond_to :user
      end
      it 'should return the correct user' do
        @moment.user.should == @user
      end
      it 'should not destroy associated user' do
        @moment.destroy
        User.find_by_id(@user.id).should_not be_nil
      end
    end
  end
end

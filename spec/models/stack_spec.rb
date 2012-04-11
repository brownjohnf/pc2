require 'spec_helper'

describe Stack do
  before(:each) do
    @user = Factory(:user)
    @attr = {
      :library_id => Factory(:library).id,
      :stackable_id => Factory(:document).id,
      :stackable_type => 'Document'
    }
  end

  it 'should create a new stack given valid attributes' do
    @user.stacks.create!(@attr)
  end

  # validation
  describe 'validation' do
    it 'should require a user_id' do
      Stack.new(@attr).should_not be_valid
    end
    it 'should require a library_id' do
      bad = @user.stacks.new(@attr.merge(:library_id => nil))
      bad.should_not be_valid
    end
    it 'should require a stackable_id' do
      @user.stacks.build(@attr.merge(:stackable_id => nil)).should_not be_valid
    end
    it 'should require a stackable_type' do
      @user.stacks.build(@attr.merge(:stackable_type => nil)).should_not be_valid
    end
  end

  # associations
  describe 'associations' do
    describe 'belongs_to' do
      describe 'stackable as photo' do
        before(:each) do
          @stackable = Factory.create(:photo)
          @stack = Factory.create(:stack, :stackable => @stackable)
        end
        it 'should respond to stackable attribute' do
          @stack.should respond_to :stackable
        end
        it 'should return the correct stackable' do
          @stack.stackable.should == @stackable
        end
        it 'should not destroy associated stackable' do
          @stack.destroy
          @stackable.class.find_by_id(@stackable.id).should_not be_nil
        end
      end
      describe 'stackable as document' do
        before(:each) do
          @stackable = Factory.create(:document)
          @stack = Factory.create(:stack, :stackable => @stackable)
        end
        it 'should respond to stackable attribute' do
          @stack.should respond_to :stackable
        end
        it 'should return the correct stackable' do
          @stack.stackable.should == @stackable
        end
        it 'should not destroy associated stackable' do
          @stack.destroy
          @stackable.class.find_by_id(@stackable.id).should_not be_nil
        end
      end
      describe 'stackable as user' do
        before(:each) do
          @stackable = Factory.create(:user)
          @stack = Factory.create(:stack, :stackable => @stackable)
        end
        it 'should respond to stackable attribute' do
          @stack.should respond_to :stackable
        end
        it 'should return the correct stackable' do
          @stack.stackable.should == @stackable
        end
        it 'should not destroy associated stackable' do
          @stack.destroy
          @stackable.class.find_by_id(@stackable.id).should_not be_nil
        end
      end
      describe 'library' do
        before(:each) do
          @library = Factory.create(:library)
          @stack = Factory.create(:stack, :library => @library)
        end
        it 'should respond to library attribute' do
          @stack.should respond_to :library
        end
        it 'should return the correct library' do
          @stack.library.should == @library
        end
        it 'should not destroy associated library' do
          @stack.destroy
          Library.find_by_id(@library.id).should_not be_nil
        end
      end
      describe 'user' do
        before(:each) do
          @user = Factory.create(:user)
          @stack = Factory.create(:stack, :user => @user)
        end
        it 'should respond to user attribute' do
          @stack.should respond_to :user
        end
        it 'should return the correct user' do
          @stack.user.should == @user
        end
        it 'should not destroy associated user' do
          @stack.destroy
          User.find_by_id(@user.id).should_not be_nil
        end
      end
    end
  end
end

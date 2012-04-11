require 'spec_helper'

describe Document do
  before(:each) do
    @user = Factory(:user)
    @attr = {
      :file => File.new(File.join(Rails.root, 'spec', 'support', 'test.txt'))
    }
  end

  it 'should create a new document given valid attributes' do
    @user.documents.create!(@attr)
  end

  # validation
  describe 'validation' do
    it 'should require a user_id' do
      Document.new(@attr).should_not be_valid
    end
    it 'should require a file' do
      @user.documents.build(@attr.merge(:file => nil)).should_not be_valid
    end
    it { should have_attached_file(:file) }
    it { should validate_attachment_presence(:file) }
    it { should validate_attachment_content_type(:file).
      allowing('text/plain', 'text/xml', 'audio/mp3').
      rejecting('image/png', 'image/gif', 'image/jpeg') }
    it { should_not validate_attachment_size(:file) }
    it 'should create a name if missing' do
      missing_name = @user.documents.new(@attr)
      missing_name.should be_valid
    end
    it 'should allow a custom name' do
      name = 'this is a custom name'
      doc = @user.documents.create(@attr.merge(:name => name))
      doc.name.should == name
    end
    it 'should set the doc info' do
      doc = @user.documents.create(@attr)
      doc.file_file_name.should_not be_nil
      doc.file_content_type.should_not be_nil
      doc.file_file_size.should_not be_nil
      doc.file_updated_at.should_not be_nil
    end
    it 'should accept tags' do
      tags = 'tag1,tag2'
      @photo = @user.documents.create(@attr.merge(:tag_list => tags))
      @photo.tag_list.should == tags.split(',')
    end
  end

  # properties
  describe 'properties' do
    build_document
    it 'should set the name in the address' do
      @document.should respond_to(:to_param)
      @document.to_param.should == "#{@document.id}-#{@document.name.parameterize}"
    end
    it 'should change the name' do
      new_name = 'new name'
      @document.name = new_name
      @document.save!
      @document.name.should == new_name
    end
    it 'should respond to tags attribute' do
      @document.should respond_to :tags
      @document.tags.should be_a_kind_of Array
    end
    it 'should respond to tag_list' do
      @document.should respond_to :tag_list
      @document.tag_list.should be_a_kind_of Array
    end
  end

  # associations
  describe 'associations' do
    build_document
    describe 'stacks' do
      build_document_stacks
      it 'should have a stacks attribute' do
        @document.should respond_to(:stacks)
      end
      it 'should return the correct stacks' do
        @document.stacks.should == [@stack]
      end
      it 'should destroy photos' do
        @document.destroy
        Stack.find_by_id(@stack.id).should be_nil
      end
    end
    describe 'libraries' do
      build_document_stacks
      it 'should have a libraries attribute' do
        @document.should respond_to(:libraries)
      end
      it 'should return the correct libraries' do
        @document.libraries.should == [@stack.library]
      end
      it 'should not destroy libraries' do
        @document.destroy
        Library.find_by_id(@stack.library.id).should_not be_nil
      end
    end
    describe 'roles' do
      build_document
      it 'should have a roles attribute' do
        @document.should respond_to(:roles)
      end
      it 'should have at least one role' do
        @document.roles.count.should > 0
      end
      it 'should not destroy roles' do
        @roles = @document.roles
        @document.destroy
        @roles.each do |role|
          Role.all.include?(role).should be_true
        end
      end
    end
    describe 'language' do
      build_document_language
      it 'should respond to language attribute' do
        @document.should respond_to :language
      end
      it 'should return the correct language' do
        @document.language.should == @language
      end
      it 'should not destroy associated language' do
        @document.destroy
        Language.find_by_id(@language.id).should_not be_nil
      end
    end
    describe 'user' do
      build_user_documents
      it 'should respond to user attribute' do
        @document.should respond_to :user
      end
      it 'should return the correct user' do
        @document.user.should == @user
      end
      it 'should not destroy associated user' do
        @document.destroy
        User.find_by_id(@user.id).should_not be_nil
      end
    end
  end
end

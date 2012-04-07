module ModelMacros

  # photo
  def build_photo
    before(:each) do
      @photo = Factory.create(:photo)
    end
  end

  # user
  def build_user
    before(:each) do
      @user = Factory.create(:user)
    end
  end
  
  def build_user_volunteers
    before(:each) do
      @volunteer = Factory.create(:volunteer, :user => @user)
    end
  end
  
  def build_user_staff
    before(:each) do
      @staff = Factory.create(:staff, :user => @user)
    end
  end
  
  def build_user_moments
    before(:each) do
      @moment = Factory.create(:moment, :user => @user)
    end
  end
  
  def build_user_blogs
    before(:each) do
      @blog = Factory.create(:blog, :user => @user) 
    end
  end
  
  def build_user_libraries
    before(:each) do
      @library = Factory.create(:library, :user => @user)
    end
  end
  
  def build_user_documents
    before(:each) do
      @document = Factory.create(:document, :user => @user)
    end
  end
  
  def build_user_sites
    before(:each) do
      @site = Factory.create(:site, :user => @user)
    end
  end
  
  def build_user_websites
    before(:each) do
      @website = Factory.create(:website, :user => @user)
    end
  end
  
  def build_user_stacks
    before(:each) do
      @user2 = Factory.create(:user)
      @library = Factory.create(:library)
      @stack = Factory.create(:stack, :stackable => @user, :library => @library, :user => @user2)
    end
  end

  def build_user_added_stacks
    before(:each) do
      @library = Factory.create(:library)
      @document = Factory.create(:document)
      @stack = Factory.create(:stack, :stackable => @document, :library => @library, :user => @user)
    end
  end
  
  def build_user_contributions
    before(:each) do
      @page = Factory.create(:page)
      @contribution = Factory.create(:contribution, :contributable => @page, :user => @user)
    end
  end
  
  def build_user_photos
    before(:each) do
      @photo = Factory.create(:photo, :imageable => @user, :user => @user)
    end
  end

  def build_user_photo
    before(:each) do
      @user = Factory.create(:user)
      @photo = Factory.create(:photo)
      @user.photo = @photo
    end
  end

end

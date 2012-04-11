module ModelMacros
  
  # case study
  def build_case_study
    before(:each) do
      @case_study = Factory.create(:case_study)
    end
  end

  # document
  def build_document
    before(:each) do
      @document = Factory.create(:document)
    end
  end

  def build_document_stacks
    before(:each) do
      @stack = Factory.create(:stack, :stackable => @document)
    end
  end

  def build_document_language
    before(:each) do
      @language = Factory.create(:language)
      @document.language = @language
    end
  end

  # moment
  def build_moment
    before(:each) do
      @moment = Factory.create(:moment)
    end
  end

  def build_moment_photos
    before(:each) do
      @photo = Factory.create(:photo, :imageable => @moment)
    end
  end

  def build_moment_photo
    before(:each) do
      @photo = Factory.create(:photo)
      @moment.photo = @photo
    end
  end


  # page
  def build_page
    before(:each) do
      @page = Factory.create(:page)
    end
  end

  # photo
  def build_photo
    before(:each) do
      @photo = Factory.create(:photo)
    end
  end

  def build_photo_users
    before(:each) do
      @user = Factory.create(:user, :photo => @photo)
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
      @stackable = Factory.create(:document)
      @library = Factory.create(:library)
      @stack = Factory.create(:stack, :stackable => @stackable, :library => @library, :user => @user)
    end
  end

  def build_user_stacked_in
    before(:each) do
      @library = Factory.create(:library)
      @document = Factory.create(:document)
      @stack = Factory.create(:stack, :stackable => @user, :library => @library)
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

  # volunteer
  def build_volunteer
    before(:each) do
      @volunteer = Factory.create(:volunteer)
      @volunteer.user.confirm!
    end
  end

end

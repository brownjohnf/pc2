module PagesHelper

  include ActsAsTaggableOn::TagsHelper
  
  def allowed_pages(user = current_user)
    @pages = user.viewable_pages
  end

end

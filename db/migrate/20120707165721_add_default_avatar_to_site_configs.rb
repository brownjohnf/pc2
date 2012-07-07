class AddDefaultAvatarToSiteConfigs < ActiveRecord::Migration
  def change
    SiteConfig.create(:name => :default_avatar, :setting => 'Please upload a file.', :description => 'This will set default avatar data throughout the site.', :photo_file_name => 'blank.png', :photo_content_type => 'image/png', :photo_file_size => 4259, :photo_updated_at => Time.now)
  end
end

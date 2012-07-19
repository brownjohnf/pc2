namespace :db do
  task :update_config => :environment do
    update_config_vars
  end
end

def update_config_vars
  config_vars = [{
    :name => 'site_title', 
    :setting => 'DigitalPost', 
    :description => 'The blue part of the main title on the menu bar, and in the browser window.',
    :title => 'Site Title',
    :category => 'general'
  },{
    :name => 'timeline_title', 
    :setting => 'Post History', 
    :description => 'The name of the Post timeline. 50th Timeline, Post Timeline, History, etc.',
    :title => 'Timeline Title',
    :category => 'timeline'
  },{
    :name => 'timeline_subtitle', 
    :setting => 'A look back through time.', 
    :description => 'Tagline for the timeline. Will appear at the top of the timeline, and on the first and last slide.',
    :title => 'Timeline Subtitle',
    :category => 'timeline'
  },{
    :name => 'timeline_intro', 
    :setting => "We're pleased and proud to celebrate our years of service. We'd like to take this opportunity to look back on the past, and share stories and photos from our Volunteers past and present. If you've got a story, photo or video you'd like to share, you can do so by logging in or signing up on our website.", 
    :description => 'The paragraph which will appear on the opening slide of the timeline.',
    :title => 'Timeline Intro',
    :category => 'timeline'
  },{
    :name => 'timeline_outro', 
    :setting => 'Thanks for joining us on this look back. We hope you enjoyed it.', 
    :description => 'The paragraph which will appear on the last slide of the timeline.',
    :title => 'Timeline Outro',
    :category => 'timeline'
  },{
    :name => 'timeline_intro_photo', 
    :setting => 'Please upload a photo...', 
    :description => 'The photo which will appear on the first slide of the timeline.',
    #:photo_file_name => 'blank.png', 
    #:photo_content_type => 'image/png', 
    #:photo_file_size => 4259, 
    #:photo_updated_at => Time.now,
    :photo => File.open(File.join(File.dirname(__FILE__), 'fixtures', 'blank.png')),
    :title => 'Timeline Intro Photo',
    :category => 'timeline'
  },{
    :name => 'timeline_outro_photo', 
    :setting => 'Please upload a photo...', 
    :description => 'The photo which will appear on the last slide of the timeline.',
    :photo => File.open(File.join(File.dirname(__FILE__), 'fixtures', 'blank.png')),
    #:photo_file_name => 'blank.png', 
    #:photo_content_type => 'image/png', 
    #:photo_file_size => 4259, 
    #:photo_updated_at => Time.now,
    :title => 'Timeline Outro Photo',
    :category => 'timeline'
  },{
    :name => 'default_avatar', 
    :setting => 'Please upload a file...', 
    :description => 'This will set default avatar data throughout the site.', 
    :photo => File.open(File.join(File.dirname(__FILE__), 'fixtures', 'blank.png')),
    #:photo_file_name => 'blank.png', 
    #:photo_content_type => 'image/png', 
    #:photo_file_size => 4259, 
    #:photo_updated_at => Time.now,
    :title => 'Default Avatar',
    :category => 'general'
  }]
  for var in config_vars do
    if SiteConfig.find_by_name(var[:name]).nil?
      SiteConfig.create!(var)
    else
      SiteConfig.find_by_name(var[:name]).update_attributes(:description => var[:description], :title => var[:title], :category => var[:category])
    end
  end

end

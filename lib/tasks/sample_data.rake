namespace :db do
	task :sample_data => :environment do
		Rake::Task['db:drop'].invoke
		Rake::Task['db:create'].invoke
		Rake::Task['db:schema:load'].invoke
    Rake::Task['db:seed'].invoke
    Rake::Task['db:update_config'].invoke
    make_pc_regions
    make_sectors
    make_languages
    make_regiontypes
		make_regions
    make_admin
    make_moderator
    make_users
    make_volunteers
    make_staff
    make_pages
    make_case_studies
    make_files
    make_photos
		Rake::Task['db:populate_timeline'].invoke
    make_ticket_stuff
    make_libraries
	end
end

def make_pc_regions
  pc_regions = PcRegion.create!([
    { name: 'Africa', short: 'AF'},
    { name: 'North Africa & The Middle East', short: 'NA/ME'},
    { name: 'Eastern Europe & Central Asia', short: 'EE/CA'},
    { name: 'Asia', short: 'AS'},
    { name: 'The Pacific Islands', short: 'PAC'},
    { name: 'The Caribbean', short: 'CAB'},
    { name: 'Central America & Mexico', short: 'CA/M'},
    { name: 'South America', short: 'SA'}
  ])
end

def make_sectors
  sectors = Sector.create!([
    { name: 'Agroforestry Extension' },
    { name: 'Community Enterprise Development' },
    { name: 'Urban Agriculture' },
    { name: 'Rural Agriculture' },
    { name: 'Eco-tourism' },
    { name: 'Health Education' },
    { name: 'Environmental Education' }
  ])
end

def make_admin
  jack = User.create!(
    :name => 'Jack Brown',
    :email => 'jack@brownjohnf.com',
    :password => 'testing1',
    :country => 'SN',
  )
  jack.volunteers.create!(
    :local_name => 'Babakar Ndiaye',
    :country => 'SN'
  )
  jack.staff.create!(
    :country => 'SN'
  )
  jack.blogs.create!(
    :title => 'Senegal et al',
    :description => 'Info about my life in Senegal.',
    :url => 'http://senegaletal.brownjohnf.com'
  )
  admin = jack
  admin.roles << Role.find_by_name('Admin')
  admin.confirmed_at = Time.now
  admin.save!  
end

def make_moderator
  jack = User.create!(
    :name => 'Moderator',
    :email => 'moderator@example.com',
    :password => 'password',
    :country => 'SN',
  )
  mod = jack
  mod.roles << Role.find_or_create_by_name('Moderator')
  mod.confirmed_at = Time.now
  mod.save!  
end

def make_languages
  languages = Language.create!([
    { :name => 'Sereer', :code => 'SE', :description => 'A lovely little language.' }
  ])
end

def make_users
  25.times do |n|
    user = User.create!(
      :name => Faker::Name.name, 
      :email => Faker::Internet.email,
      :password => 'testing', 
      :country => 'SN',
      :tag_list => 'tag1, tag2, tag3'
    )
    user.confirmed_at = Time.now
    user.save!
  end
end

def make_volunteers
  50.times do |n|
    user = User.create!(
      :name => Faker::Name.name, 
      :email => Faker::Internet.email, 
      :password => 'testing', 
      :country => 'SN',
      :tag_list => 'tag1, tag2, tag3'
    )
    user.confirmed_at = Time.now
    user.save!
    user.volunteers.create!(:local_name => Faker::Name.name, :country => 'SN')
  end
end

def make_staff
  25.times do |n|
    user = User.create!(
      :name => Faker::Name.name, 
      :email => Faker::Internet.email, 
      :password => 'testing', 
      :country => 'SN',
      :tag_list => 'tag1, tag2, tag3'
    )
    user.confirmed_at = Time.now
    user.save!
    user.staff.create!(:country => 'SN')
  end
end

def make_regiontypes
	Regiontype.create!(:name => 'Rural Community')
end

def make_regions
	Region.create!([
    { name: 'Dakar', short: 'DKR', country: 'SN', type_id: 1, parent_id: nil },
    { name: 'Kaolack', short: 'DKR', country: 'SN', type_id: 1, parent_id: nil },
    { name: 'Saint-Louis', short: 'DKR', country: 'SN', type_id: 1, parent_id: nil },
    { name: 'Tambacounda', short: 'DKR', country: 'SN', type_id: 1, parent_id: nil },
    { name: 'Kaffrine', short: 'DKR', country: 'SN', type_id: 1, parent_id: nil },
    { name: 'Kedougou', short: 'DKR', country: 'SN', type_id: 1, parent_id: nil },
    { name: 'Kolda', short: 'DKR', country: 'SN', type_id: 1, parent_id: nil },
    { name: 'Louga', short: 'DKR', country: 'SN', type_id: 1, parent_id: nil },
    { name: 'Linguere', short: 'DKR', country: 'SN', type_id: 1, parent_id: nil },
    { name: 'Mattam', short: 'DKR', country: 'SN', type_id: 1, parent_id: nil },
    { name: 'Ziguinchor', short: 'DKR', country: 'SN', type_id: 1, parent_id: nil },
    { name: 'Thies', short: 'DKR', country: 'SN', type_id: 1, parent_id: nil }
  ])
end

def make_pages
  [Volunteer, Staff].each do |a|
    a.all.each do |b|
      page = Page.create!(
        :title => Faker::Company.catch_phrase, 
        :description => Faker::Company.catch_phrase,
        :content => Faker::Lorem.paragraphs(8), 
        :country => 'SN', 
        :language_id => 1+rand(2),
        :tag_list => 'tag1, tag2, tag3'
      )
      page.contributions.build(:user_id => b.user.id)
      page.save!
    end
  end
  start = 11
  middle = Page.count - 15
  Page.where(:id => start..middle).each do |page|
    page.parent_id = 1 + rand(start - 2)
    page.save!
  end
  Page.where('id > ?', middle).each do |page|
    page.parent_id = start + rand(middle - start)
    page.save!
  end
  Page.rebuild!
  Page.all.each do |page|
    page.title = "#{page.title} (#{page.children.count})"
    page.save!
  end
end

def make_case_studies
  [Volunteer, Staff].each do |a|
    a.all.each do |b|
      case_study = CaseStudy.create!(
        :title => Faker::Company.catch_phrase, 
        :summary => Faker::Lorem.paragraphs(8), 
        :country => 'SN', 
        :language_id => 1+rand(2),
        :tag_list => 'tag1, tag2, tag3'
      )
      case_study.contributions.build(:user_id => b.user.id)
      case_study.save!
    end
  end
end

def make_files
  [Volunteer, Staff].each do|a|
    a.all.each do |b|
      document = b.user.documents.build(
        :name => Faker::Company.catch_phrase,
        :description => Faker::Company.catch_phrase,
        :file => File.open(File.join(File.dirname(__FILE__), 'fixtures', 'test.pdf')),
        :source => File.open(File.join(File.dirname(__FILE__), 'fixtures', 'test.docx')),
        :country => 'SN',
        :tag_list => 'tag1, tag2, tag3'
      )
      document.file_fingerprint = SecureRandom.hex(10)
      document.source_fingerprint = SecureRandom.hex(10)
      document.save!
    end
  end
end

def make_photos
  [Volunteer, Staff].each do |a|
    a.all.each do |b|
      photo = b.user.photos.build(
        :photo => File.open(File.join(File.dirname(__FILE__), 'fixtures', 'test.png'))
      )
      photo.imageable = b
      photo.photo_fingerprint = SecureRandom.hex(10)
      photo.save!
    end
  end
end

def make_ticket_stuff
  [ Volunteer, Staff ].each do |a|
    a.all.each do |b|
      ticket = Ticket.create!(
        :ticket_category_id => TicketCategory.first.id,
        :priority_id => Priority.first.id,
        :subject => Faker::Company.catch_phrase,
        :body => Faker::Company.catch_phrase
      )
      TicketOwner.create!(
        :from_id => b.id,
        :to_id => User.count - b.id + 1,
        :ticket_id => ticket.id,
        :ticket_code_id => Priority.first.id
      )
    end
  end
end

def make_libraries
  10.times do |n|
    Library.create(:name => "Test Library #{n}", :country => 'SN', :user_id => User.first.id)
  end
  [ Document, Photo ].each do |item|
    item.all.each do |item2|
      Stack.create(:library_id => Library.find(1+rand(Library.count)).id, :user_id => User.first.id, :stackable_id => item2.id, :stackable_type => item.to_s)
    end
  end
end

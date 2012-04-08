namespace :db do
	task :sample_data => :environment do
		Rake::Task['db:reset'].invoke
    Rake::Task['db:seed'].invoke
    make_pc_regions
    make_sectors
    make_languages
    make_regiontypes
		make_regions
    make_user
    make_users
    make_volunteers
    make_staff
    make_pages
    make_case_studies
		Rake::Task['db:populate_timeline'].invoke
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

def make_user
  jack = User.create!(
    :name => 'Jack Brown',
    :email => 'jack@brownjohnf.com',
    :password => 'testing',
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
    :url => 'http://senegaletal.blogspot.com'
  )
  admin = jack
  admin.roles << Role.find_by_name('Admin')
  admin.confirmed_at = Time.now
  admin.save!  
end

def make_languages
  languages = Language.create!([
    { :name => 'Sereer', :code => 'SE', :description => 'A lovely little language.' },
    { :name => 'English', :code => 'EN', :description => 'The greatest language in the world.' }
  ])
end

def make_users
  25.times do |n|
    user = User.create!(
      :name => Faker::Name.name, 
      :email => Faker::Internet.email,
      :password => 'testing', 
      :country => 'SN'
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
      :country => 'SN'
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
      :country => 'SN'
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
        :description => Faker::Lorem.paragraph, 
        :content => Faker::Lorem.paragraphs(8), 
        :country => 'SN', 
        :language_id => 1+rand(2)
      )
      page.contributions.build(:user_id => b.user.id)
      page.save!
    end
  end
  page_count = Page.count
  Page.all.each do |page|
    page.parent_id = 1 + rand(page_count)
  end
  Page.rebuild!
end

def make_case_studies
  [Volunteer, Staff].each do |a|
    a.all.each do |b|
      case_study = CaseStudy.create!(
        :title => Faker::Company.catch_phrase, 
        :summary => Faker::Lorem.paragraphs(8), 
        :country => 'SN', 
        :language_id => 1+rand(2)
      )
      case_study.contributions.build(:user_id => b.user.id)
      case_study.save!
    end
  end
end


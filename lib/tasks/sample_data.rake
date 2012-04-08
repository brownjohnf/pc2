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
  99.times do |n|
    name = Faker::Name.name
    email = Faker::Internet.email
    user = User.create!(:name => name, :email => email, :country => 'SN')
    user.volunteers.create!(:local_name => Faker::Name.name, :country => 'SN')
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

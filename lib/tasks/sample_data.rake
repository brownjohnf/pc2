namespace :db do
	task :populate => :environment do
		Rake::Task['db:reset'].invoke
		make_users
		make_memberships
		make_regiontypes
		make_regions
	end
end

def make_users
  99.times do |n|
    name = Faker::Name.name
    email = "example-#{n+1}@example.org"
    user = User.create!(:name => name, :email => email, :country_id => 1, :bio => '# Bio Here')
    user.volunteers.create!(:local_name => Faker::Name.name, :sector_id => 1+rand(7))
  end
end

def make_memberships
end

def make_regiontypes
	Regiontype.create!(:name => 'Region')
end

def make_regions
	Region.create!(
									[
									 { name: 'Kaolack', short: 'KLK', country_id: 1, type_id: 1, parent_id: nil }
									]
								)
end

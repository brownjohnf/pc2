namespace :db do
	task :populate => :environment do
		Rake::Task['db:reset'].invoke
		make_users
		make_memberships
		make_regiontypes
		make_regions
		make_moments
	end
end

def make_users
  99.times do |n|
    name = Faker::Name.name
    email = Faker::Internet.email
    user = User.create!(:name => name, :email => email, :country_id => 1+rand(5), :bio => '# Bio Here')
    user.volunteers.create!(:local_name => Faker::Name.name, :sector_id => 1+rand(7), :site_id => 1)
  end
end

def make_memberships
end

def make_regiontypes
	Regiontype.create!(:name => 'Rural Community')
end

def make_regions
	Region.create!(
									[
									 { name: 'Dakar', short: 'DKR', country_id: 3, type_id: 1, parent_id: nil },
									 { name: 'Kaolack', short: 'DKR', country_id: 3, type_id: 1, parent_id: nil },
									 { name: 'Saint-Louis', short: 'DKR', country_id: 3, type_id: 1, parent_id: nil },
									 { name: 'Tambacounda', short: 'DKR', country_id: 3, type_id: 1, parent_id: nil },
									 { name: 'Kaffrine', short: 'DKR', country_id: 3, type_id: 1, parent_id: nil },
									 { name: 'Kedougou', short: 'DKR', country_id: 3, type_id: 1, parent_id: nil },
									 { name: 'Kolda', short: 'DKR', country_id: 3, type_id: 1, parent_id: nil },
									 { name: 'Louga', short: 'DKR', country_id: 3, type_id: 1, parent_id: nil },
									 { name: 'Linguere', short: 'DKR', country_id: 3, type_id: 1, parent_id: nil },
									 { name: 'Mattam', short: 'DKR', country_id: 3, type_id: 1, parent_id: nil },
									 { name: 'Ziguinchor', short: 'DKR', country_id: 3, type_id: 1, parent_id: nil },
									 { name: 'Thies', short: 'DKR', country_id: 3, type_id: 1, parent_id: nil }
									]
								)
end

namespace :db do
	task :populate => :environment do
		Rake::Task['db:reset'].invoke
		make_users
		make_countries
		make_pcregions
		make_groups
		make_memberships
		make_regiontypes
		make_regions
	end
end

def make_pcregions
	Pcregion.create!(:name => 'Sub-Saharan Africa', :short => 'SSA')
end

def make_countries
	Country.create!(:name => 'Senegal', :short => 'SN', :pcregion_id => 1)
end

def make_users
	User.create!(:name => 'Jack Brown', :email => 'jack@brownjohnf.com', :country_id => 1, :bio => '# Bio Here')
  99.times do |n|
    name = Faker::Name.name
    email = "example-#{n+1}@railstutorial.org"
    User.create!(:name => name, :email => email, :country_id => 1, :bio => '# Bio Here')
  end
end

def make_groups
	Group.create!(:name => 'User')
	Group.create!(:name => 'Administrator')
	Group.create!(:name => 'Moderator')
end

def make_memberships
	Membership.create!(:user_id => 1, :group_id => 1)
	Membership.create!(:user_id => 1, :group_id => 2)
	Membership.create!(:user_id => 1, :group_id => 3)
end

def make_regiontypes
	Regiontype.create!(:name => 'Region')
end

def make_regions
	Region.create!(:name => 'Kaolack', :short => 'KLK', :country_id => 1, :type_id => 1, :parent_id => nil)
end

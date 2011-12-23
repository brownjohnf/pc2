namespace :db do
	task :populate => :environment do
		#Rake::Task['db:reset'].invoke
		make_users
	end
end

def make_users
  99.times do |n|
    name = Faker::Name.name
    email = "example-#{n+1}@railstutorial.org"
    User.create!(:name => name, :email => email)
  end
end

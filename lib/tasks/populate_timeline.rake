namespace :db do
  task :populate_timeline => :environment do
    Moment.destroy_all
    make_moments
  end
end

def make_moments
  Volunteer.all.each do |volunteer|
    Moment.create!([{
      :headline => Faker::Company.catch_phrase, 
      :text => Faker::Lorem.paragraph, 
      :media => Faker::Lorem.paragraphs(1), 
      :user_id => volunteer.user.id,
      :country => volunteer.country,
      :startdate => (1963+rand(35)).to_s + '-' + (1+rand(12)).to_s + '-' + (1+rand(28)).to_s
    }])
  end
end

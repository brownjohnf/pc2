namespace :db do
  task :populate_timeline => :environment do
    Moment.destroy_all
    make_moments
  end
end

def make_moments
  Volunteer.all.each do |volunteer|
    Moment.create!([{
      :title => Faker::Company.catch_phrase, 
      :summary => Faker::Lorem.paragraph, 
      :content => Faker::Lorem.paragraphs(8), 
      :user_id => volunteer.user.id,
      :country => volunteer.country,
      :datapoint => (1963+rand(35)).to_s + '-' + (1+rand(12)).to_s + '-' + (1+rand(28)).to_s
    }])
  end
end

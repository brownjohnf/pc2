namespace :db do
  task :populate_timeline => :environment do
    Moment.destroy_all
    make_moments
  end
end

def make_moments
  99.times do |n|
    moment = Moment.create!(
                    [
                      {
                        :title => Faker::Company.catch_phrase, 
                        :summary => Faker::Lorem.paragraph, 
                        :content => Faker::Lorem.paragraphs(8), 
                        :photo_id => 2, 
                        :user_id => 1, 
                        :datapoint => (1963+rand(35)).to_s + '-' + (1+rand(12)).to_s + '-' + (1+rand(30)).to_s }
                    ]
                  )
  end
end
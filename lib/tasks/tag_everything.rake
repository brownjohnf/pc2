namespace :db do
	task :tag_everything => :environment do
    [ Document, Photo, Page, CaseStudy, User ].each do |item|
      item.all.each do |item2|
        item2.update_attribute(:tag_list, Faker::Lorem.words.join(', '))
      end
    end
	end
end

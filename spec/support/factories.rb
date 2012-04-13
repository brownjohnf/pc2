FactoryGirl.define do
  
  factory :page do
    sequence(:title) { |n| "Factory Generated Title #{n}" }
    description 'Description'
    content 'Content'
    language_id 1
    country 'SN'
  end

  factory :photo do
    association :user
    association :imageable, :factory => :user
    photo { File.new(File.join(Rails.root, 'spec', 'support', 'test.png')) }
    sequence(:photo_fingerprint) { |n| "#{n}#{SecureRandom.hex(10)}" }
  end

  factory :case_study do
    sequence(:title) { |n| "Factory Generated Title #{n}" }
    summary 'Factory summary'
    country 'SN'
    language_id 1
    association :photo
  end

end

Factory.define :photo, :class => Photo do |p|
  p.association :user, :factory => :user
  p.association :imageable, :factory => :user
  p.photo { File.new(File.join(Rails.root, 'spec', 'support', 'test.png')) }
end


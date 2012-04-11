Factory.define :mp3, :class => Document do |m|
  m.association :user, :factory => :user
  m.file { File.new(File.join(Rails.root, 'spec', 'support', 'test.mp3')) }
end


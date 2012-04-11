Factory.define :document, :class => Document do |d|
  d.association :user, :factory => :user
  d.file { File.new(File.join(Rails.root, 'spec', 'support', 'test.txt')) }
end


Factory.define :site, :class => Site do |s|
  s.name 'Test Site'
  s.association :user
end


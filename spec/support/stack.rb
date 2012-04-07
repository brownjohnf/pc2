Factory.define :stack, :class => Stack do |s|
  s.association :library, :factory => :library
  s.association :user, :factory => :user
  s.association :stackable, :factory => :document
end


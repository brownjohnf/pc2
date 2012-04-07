Factory.define :library, :class => Library do |l|
  l.name 'Test Library'
  l.country 'SN'
  l.association :user
end


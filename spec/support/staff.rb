Factory.define :staff, :class => Staff do |s|
  s.country 'SN'
  s.association :user
end


Factory.define :volunteer, :class => Volunteer do |v|
  v.country 'SN'
  v.cos_date Time.now
  v.association :user, :factory => :user
end


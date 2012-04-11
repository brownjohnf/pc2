Factory.define :moment, :class => Moment do |m|
  m.title 'Test Title'
  m.summary 'Test summary'
  m.datapoint Time.now.to_date
  m.association :user, :factory => :user
end


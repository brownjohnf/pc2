Factory.define :blog, :class => Blog do |b|
  b.url 'http://blog.brownjohnf.com'
  b.association :user
end


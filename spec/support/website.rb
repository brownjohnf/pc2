Factory.define :website, :class => Website do |w|
  w.name 'Test Website'
  w.url 'http://www.brownhjohnf.com'
  w.association :user
end


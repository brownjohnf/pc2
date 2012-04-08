Factory.define :case_study, :class => CaseStudy do |c|
  c.title { Factory.next(:title) }
  c.summary 'Factory summary'
  c.country 'SN'
  c.language_id 1
end

Factory.sequence :title do |n|
  "Factory Generated Title #{n}"
end

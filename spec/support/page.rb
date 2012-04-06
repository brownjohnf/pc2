Factory.define :page, :class => Page do |p|
  p.title { Factory.next(:title) }
  p.description 'Description'
  p.content 'Content'
  p.language_id 1
  p.country 'SN'
end


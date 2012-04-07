Factory.define :contribution, :class => Contribution do |c|
  # can be either page or case study
  c.association :contributable, :factory => :page
  c.association :user, :factory => :user
end


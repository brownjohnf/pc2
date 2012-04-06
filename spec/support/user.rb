Factory.define :user, :class => User do |u|
  u.name 'Test User'
  u.email { Factory.next(:email) }
  u.password 'testing'
end

Factory.sequence :email do |n|
  "test-#{n}@example.com"
end


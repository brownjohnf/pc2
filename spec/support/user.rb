Factory.define :user, :class => User do |u|
  u.name { Factory.next(:name) }
  u.email { Factory.next(:email) }
  u.password 'testing'
  u.avatar nil
end

Factory.sequence :email do |n|
  "test-#{n}@example.com"
end

Factory.sequence :name do |n|
  "Test User #{n}"
end


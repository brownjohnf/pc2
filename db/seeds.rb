# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Role.create!([
  {:name => 'Public', :long_name => 'Anyone, all and sundry'},
  {:name => 'Invitee', :long_name => 'Invitees'},
  {:name => 'Trainee', :long_name => 'Trainees'},
  {:name => 'User', :long_name => 'Registered users (PC and non-PC)'},
  {:name => 'Volunteer', :long_name => 'Peace Corps Volunteers'},
  {:name => 'Staff', :long_name => 'Peace Corps Staff'},
  {:name => 'Moderator', :long_name => 'Site Moderators (PCVLs)'},
  {:name => 'Admin', :long_name => 'Site Administrator'}
])

Scope.create!([
  { name: 'Page', title: 'Page', description: 'Page-related privileges.' },
  { name: 'User', title: 'User/Volunteer/Staff Profile', description: 'Ability to modify users' },
  { name: 'Photo', title: 'Photo', description: 'Ability to modify users' },
  { name: 'Library', title: 'Library', description: 'Ability to modify users' },
  { name: 'CaseStudy', title: 'Case Study', description: 'Ability to modify case studies' }
])

Language.create(
  :name => 'English',
  :code => 'EN',
  :description => 'Default app language.'
)

Page.create!([
  {
    :title => 'About us', 
    :description => 'Sample about us page', 
    :content => 'This is the About us page created by default. Please DO NOT delete it, but edit it to reflect your post.', 
    :country => 'SN', 
    :language_id => Language.find_by_code('EN').id
  },{
    :title => 'What We Do', 
    :description => 'Sample what we do page', 
    :content => "This is the What We Do page created by default. Please DO NOT delete it, but edit it to reflect your post's activities.", 
    :country => 'SN', 
    :language_id => Language.find_by_code('EN').id
  }
])

Rake::Task['db:initialize_ticket_data'].invoke

user = User.create!({
  :name => 'Administrator',
  :email => 'admin@example.com',
  :password => 'password',
  :country => 'SN'
});
user.confirmed_at = Time.now
for role in Role.all do
  user.roles.delete(role)
  user.roles << role
end
user.save!

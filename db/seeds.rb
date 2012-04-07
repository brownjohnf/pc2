# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Role.create!([
  {:name => 'Public'},
  {:name => 'User'},
  {:name => 'Volunteer'},
  {:name => 'Staff'},
  {:name => 'Moderator'},
  {:name => 'Admin'}
])

Scope.create!([
  { name: 'Page', title: 'Page', description: 'Page-related privileges.' },
  { name: 'User', title: 'User/Volunteer/Staff Profile', description: 'Ability to modify users' },
  { name: 'Photo', title: 'Photo', description: 'Ability to modify users' },
  { name: 'Library', title: 'Library', description: 'Ability to modify users' },
  { name: 'CaseStudy', title: 'Case Study', description: 'Ability to modify case studies' }
])


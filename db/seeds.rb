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

scopes = Scope.create!(
                       [
                         { name: 'Page', title: 'Page', description: 'Page-related privileges.' },
                         { name: 'User', title: 'User/Volunteer/Staff Profile', description: 'Ability to modify users' },
                         { name: 'Photo', title: 'Photo', description: 'Ability to modify users' },
                         { name: 'Library', title: 'Library', description: 'Ability to modify users' },
                         { name: 'CaseStudy', title: 'Case Study', description: 'Ability to modify case studies' }
                       ]
                     )
pc_regions = PcRegion.create!(
                             [
                                { name: 'Africa', short: 'AF'},
                                { name: 'North Africa & The Middle East', short: 'NA/ME'},
                                { name: 'Eastern Europe & Central Asia', short: 'EE/CA'},
                                { name: 'Asia', short: 'AS'},
                                { name: 'The Pacific Islands', short: 'PAC'},
                                { name: 'The Caribbean', short: 'CAB'},
                                { name: 'Central America & Mexico', short: 'CA/M'},
                                { name: 'South America', short: 'SA'}
                             ]
                           )
sectors = Sector.create!(
                          [
                            { name: 'Agroforestry Extension' },
                            { name: 'Small Enterprise Development' },
                            { name: 'Urban Agriculture' },
                            { name: 'Rural Agriculture' },
                            { name: 'Eco-tourism' },
                            { name: 'Health Education' },
                            { name: 'Environmental Education' }
                          ]
)

jack = User.create!(
                    :name => 'Jack Brown',
                    :email => 'jack@brownjohnf.com',
                    :password => 'testing',
                    :country => 'SN',
                    :bio => '# Bio Here')
jack.volunteers.create!(
                        :local_name => 'Babakar Ndiaye',
                        :emphasis => 'Media',
                        :projects => 'Website, How-To Videos',
                        :sector_id => 1,
                        :site_id => 1
                       )
jack.blogs.create!(
                    :title => 'Senegal et al',
                    :description => 'Info about my life in Senegal.',
                    :url => 'http://senegaletal.blogspot.com'
                  )
jack.memberships.create!(
                          [
                            { :group_id => 2 },
                            { :group_id => 3 }
                          ]
                        )
languages = Language.create!(
                             [
                               { :name => 'Sereer', :code => 'SE', :description => 'A lovely little language.' },
                               { :name => 'English', :code => 'EN', :description => 'The greatest language in the world.' }
                              ]
                           )

Page.rebuild!
admin = jack
admin.roles << Role.find(1)
admin.roles << Role.find(2)
admin.roles << Role.find(3)

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


groups = Group.create(
                       [
                          { :name => 'User' },
                          { :name => 'Administrator' },
                          { :name => 'Moderator' },
                          { :name => 'Staff' }
                        ]
                      )
privileges = Privilege.create(
                               [
                                  { name: 'Edit',
                                    description: 'Ability to edit.' },
                                  { name: 'Delete',
                                    description: 'Ability to delete.' },
                                  { name: 'View',
                                    description: 'Ability to view.'}
                                ]
                              )
scopes = Scope.create([ { name: 'Page', title: 'title', description: 'Page-related privileges.' }, { name: 'Module', title: 'title', description: 'Ability to modify modules.' }, { name: 'User', title: 'title', description: 'Ability to modify users' } ])
permission = Permission.create(
                                [
                                   { group_id: 1, scope_id: 1, privilege_id: 3, comment: 'Default, base permission. Do not edit.' },
                                   { group_id: 2, scope_id: 1, privilege_id: 3, comment: 'Default, base permission. Do not edit.' },
                                   { group_id: 3, scope_id: 1, privilege_id: 3, comment: 'Default, base permission. Do not edit.' },
                                   { group_id: 2, scope_id: 1, privilege_id: 1, comment: 'Default, base permission. Do not edit.' },
                                   { group_id: 2, scope_id: 1, privilege_id: 2, comment: 'Default, base permission. Do not edit.' },
                                   { group_id: 3, scope_id: 1, privilege_id: 1, comment: 'Default, base permission. Do not edit.' },
                                   { group_id: 1, scope_id: 3, privilege_id: 3, comment: 'Default, base permission. Do not edit.' },
                                   { group_id: 2, scope_id: 3, privilege_id: 3, comment: 'Default, base permission. Do not edit.' },
                                   { group_id: 3, scope_id: 3, privilege_id: 3, comment: 'Default, base permission. Do not edit.' },
                                   { group_id: 2, scope_id: 3, privilege_id: 1, comment: 'Default, base permission. Do not edit.' },
                                   { group_id: 2, scope_id: 3, privilege_id: 2, comment: 'Default, base permission. Do not edit.' },
                                   { group_id: 3, scope_id: 3, privilege_id: 1, comment: 'Default, base permission. Do not edit.' }
                                ]
                              )
pcregions = Pcregion.create(
                             [
                                { name: 'N/A', short: 'N/A'},
                                { name: 'Sub-Saharan Africa', short: 'SSA'},
                                { name: 'North Africa / Middle East', short: 'NA/ME'}
                             ]
                           )
sectors = Sector.create(
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
countries = Country.create(
                            [
                               { name: 'None / Unknown',
                                 short: 'None',
                                 pcregion_id: 1 },
                               { name: 'United States of America',
                                 short: 'USA',
                                 pcregion_id: 2 },
                               { name: 'Senegal',
                                 short: 'SN',
                                 pcregion_id: 2 },
                               { name: 'Mali',
                                 short: 'ML',
                                 pcregion_id: 2 },
                               { name: 'The Gambia',
                                 short: 'GM',
                                 pcregion_id: 2 },
                               { name: 'Jordan',
                                 short: 'JO',
                                 pcregion_id: 3 }
                            ]
                          )

pages = Page.create(
                     [
                        { title: 'Disclaimer',
                          description: 'Legal stuff.',
                          content: 'The contents of this web site do not reflect in any way the positions of the U.S. Government or the United States Peace Corps. This web site is managed and supported by Peace Corps Volunteers and our supporters. It is not a U.S. Government web site.',
                          system: true},
                        { title: 'Privacy Policy',
                          description: 'Your rights.',
                          content: "We will never give, sell, or in any way communicate any personal information to anyone, save with the owner of said information's express permission.",
                          system: true },
                        { title: 'Support',
                          description: 'Come get help!',
                          content: 'Support is here!',
                          system: true },
                        { title: 'Security',
                          description: 'How we protect our information.',
                          content: 'All content hosted through this application is safe and secure. For more information please view our Privacy Policy.',
                          system: true },
                        { title: 'About us',
                          description: 'A little bit about us.',
                          content: "This website is running the open source Peace Corps App, currently in pre-alpha release. \nLicense \nPC Web App is copyright John F. Brown, 2011, and files herein are licensed under the Affero General Public License version 3, the text of which can be found in GNU-AGPL-3.0, or any later version of the AGPL, unless otherwise noted. Components of PC Web App, including CodeIgniter, PHP Markdown and JQuery, are licensed separately. All unmodified files from these and other sources retain their original copyright and license notices: see the relevant individual files.",
                          system: true },
                        { title: 'Calendar',
                          description: 'Our calendar.',
                          content: 'Calender goes here.',
                          system: true }
])

jack = User.create!(
                    :name => 'Jack Brown',
                    :email => 'jack@brownjohnf.com',
                    :country_id => 3,
                    :bio => '# Bio Here')
jack.volunteers.create!(
                        :local_name => 'Babakar Ndiaye',
                        :emphasis => 'Media',
                        :projects => 'Website, How-To Videos'
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

Page.rebuild!
Page.last.move_to_child_of(Page.find_by_id(5))

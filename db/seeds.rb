# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

pcregions = Pcregion.create([{ name: 'none', short: 'none'}])
countries = Country.create([{ name: 'United States of America', short: 'USA', pcregion_id: 1 }, { name: 'The Gambia', short: 'GM', pcregion_id: 1 }])
pages = Page.create([
  { title: 'Disclaimer', description: 'Legal stuff.', content: 'The contents of this web site do not reflect in any way the positions of the U.S. Government or the United States Peace Corps. This web site is managed and supported by Peace Corps Volunteers and our supporters. It is not a U.S. Government web site.' },
  { title: 'Privacy Policy', description: 'Your rights.', content: "We will never give, sell, or in any way communicate any personal information to anyone, save with the owner of said information's express permission." },
  { title: 'Support', description: 'Come get help!', content: '' },
  { title: 'Security', description: 'How we protect our information.', content: 'All content hosted through this application is safe and secure. For more information please view our Privacy Policy.' },
  { title: 'About us', description: 'A little bit about us.', content: "This website is running the open source Peace Corps App, currently in pre-alpha release.
License
PC Web App is copyright John F. Brown, 2011, and files herein are licensed under the Affero General Public License version 3, the text of which can be found in GNU-AGPL-3.0, or any later version of the AGPL, unless otherwise noted. Components of PC Web App, including CodeIgniter, PHP Markdown and JQuery, are licensed separately. All unmodified files from these and other sources retain their original copyright and license notices: see the relevant individual files." }
])

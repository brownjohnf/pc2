# Readme

The Gemfile contains both thin and foreman, and it is recommended you use thin as your client and foreman to manage it.

Start the server with 'foreman start'.

This page is located in app/views/pages/home.html.erb. Please modify it to reflect your home page.

This base comes with the following, all in vendor/assets:

#### CSS

* Blueprint
  * ie.css
  * typography.css
  * reset.css
* 1140 CSS Grid
  * 1140.css
  * styles.css.scss
  * formalize.css.scss

#### JS

* 1140 CSS Grid
  * css3-mediaqueries.js
* jquery.formalize.min.js
* jquery.url.js

#### Images

* Mostly complete icon set.

The app/assets/stylesheets/application.css loads vendor sheets, plus the default.css.scss file, into which all SASS sheets should be @imported. All SASS sheets to be imported need to begin with an underscore.

The app/assets/javascripts/application.js loads all .js files, as well as the jquery-ui plugin, served from rails.

## Setup

1. Set both your development and production API keys and secrets in /config/initializers/dev_environment.rb
2. Add yourself as an admin using the console [ User.create!(:email => 'YOUR_EMAIL', :password => 'YOUR_PASSWORD') ]
3. Start the server! [ foreman start ] It'll be available at localhost:5000

## Deploying on Heroku (assumes an existing git repository)

gem install heroku
heroku keys:add
heroku create --stack cedar
git checkout -b heroku
git push heroku heroku:master
heroku run rake db:migrate
heroku open

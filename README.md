This is a demo app which offers instant support for login using:

* Facebook
* Google
* Twitter
* Traditional username/password

It's target user group is Peace Corps posts. The structure is customized to reflect their needs, and offers support for the storage, presentation, and manipulation of the following resources:

#### Files

All sorts, including

* photos
* office docs
* PDFs
* spreadsheets

#### Users

Allows anyone to sign up for the site, has restricted access to certain resources based on permission groups. Allows users to be designated as volunteers or staff members, and tracks info such as COS date, sector, job position, etc.

#### Pages

Supports in-browser creation, management, and editing of 'static' pages. Has a built-in WYSIWYG editor, so almost no HTML knowledge is required. Supports Markdown, as well.

#### Case Studies

Similar to pages, but stored separately.

#### Libraries

Libraries allow users to build collections of files, pages, case studies, photos, and users around any theme, and then access or download the resources as a group.

## Requirements

#### PostgreSQL

To use the search functions in the app, you must be running on PostgreSQL. It's possible to develop/test with SQLite, but the tests/actions involving searches will fail.

## Installation on Heroku

#### Purchase and Configure Domain

#### Pick a Heroku app name

#### Set up Facebook App

#### Set up a Google Analytics account

#### Set up Amazon S3

need a bucket name, key, and secret

#### Set up Amazon Route 53 (should be optional, but need to set up DNS)

need root domain pointing to Heroku IP, subs pointing to heroku appname

#### Set up Amazon CloudFront (should be optional)

#### Branch / clone app from Git

#### Configure app/environments/production.rb, set MailGun domain

#### Create Heroku App

$> heroku create --stack cedar -r <remote name> <appname>

#### Push app to Heroku to initialize environment

git push <branch> <remote name>:master

#### Add domain to Heroku app

heroku domains:add <domain name> --app <appname>

#### Add Heroku Addons

heroku addons:add mailgun:starter --app <appname>

#### Set config variables on Heroku app

heroku config:add FB_KEY=<fb key> FB_SECRET=<fb secret> G_ANALYTICS_ID=<analytics id> S3_BUCKET=<bucket name> S3_KEY=<s3 key> S3_SECRET=<s3 secret>

#### Create and seed the database

heroku run rake db:migrate
heroku run rake db:seed

#### Sign in as admin, change password

Sign is as user 'Administrator', password 'password'
Change the name/email/password to be whatever you want
Make sure it's secure

You're good to go!

## Testing

Rspec tests are included. To use, run bundle exec rake db:prepare_test_db, and then bundle exec rspec spec/.

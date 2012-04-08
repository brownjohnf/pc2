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

## Installation

Jump-start instructions: clone this repository, edit the database settings, bundle install, db:migrate, db:seed

## Testing

Rspec tests are included. To use, run db:prepare_test_db, and then rspec spec/.

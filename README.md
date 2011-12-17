This is a demo app which offers instant support for login using:

* Facebook
* Google
* Twitter

Currently, it is also set up to use Github, but for some reason (non-standard Github result returns?) Github doesn't work.

Each authorized app is registered in the Authorization table, and then linked to the User table. This allows users to link multiple third-party accounts to this site.

# WeeblyBundler v0.1.0

WeeblyBundler is a CLI tool created to enable Weebly Platform Developers to rapidly deploy their apps and upload their themes.

## Installation

Please note, this process will be significantly easier once the gem is released on rubygems.

Download the source code

`git clone git@github.intern.weebly.net:weebly/weeblybundler.git`

Change to source directory and install dependencies (including bundler)

`cd weeblybundler`

`gem install bundler`

`bundle install`

Install the gem in your current gemset by running gem install with a path to the pkg/weeblybundler-0.1.0.gem in the gem's source directory.

`gem build pkg/weeblybundler.gemspec`

`gem install pkg/weeblybundler-0.1.0.gem`

Good to go!

## Usage

### Uploading Apps

Before uploading apps, you must first set your client id and client secret as environment variables. You can find these values on your app's page in the developer-admin.

`export WEEBLY_CLIENT_ID=client_id && export WEEBLY_SECRET=secret`

Now you can use the app command to sync your local changes to your app.

`weeblybundle app /Path/To/Element/Directory`

Once you have installed your app to a site from the developer-admin, you can sync your app using weeblybundle and view your changes in the editor by refreshing the page.

### Uploading Themes

Before uploading themes, you must first set your email, site_id, and site_token. You can retrieve the site_id and site_token from your editor under Settings->General->Platform API Token.

`export WEEBLY_EMAIL=weebly@woobly.com && export WEEBLY_SITE_ID=site_id && export WEEBLY_TOKEN=token`

Then upload the theme by using:

`weeblybundle theme /Path/To/Theme`

You can then see your uploaded theme under Themes->Custom.

Happy Bundling!

For developer support and questions, contact us at developer@weebly.com.

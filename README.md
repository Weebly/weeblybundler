# WeeblyBundler v0.1.0

WeeblyBundler is a CLI tool created to enable Weebly Platform Developers to rapidly deploy their apps.

## Installation

Please note, this process will be significantly easier once the gem is released on rubygems.

Download the source code

`git clone git@github.intern.weebly.net:bryan/weeblybundler.git`

Change to source directory and install dependencies (including bundler)

`cd weeblybundler`

`gem install bundler`

`bundle install`

Install the gem in your current gemset by running gem install with a path to the pkg/weeblybundler-0.1.0.gem in the gem's source directory.

`gem build pkg/weeblybundler.gemspec`

`gem install pkg/weeblybundler-0.1.0.gem`

Good to go!

## Usage

Before using weeblybundler, you must first set your client id and client secret as environment variables. You can find these values on your app's page in the developer-admin.

`export WEEBLY_CLIENT_ID=client_id && export WEEBLY_CLIENT_SECRET=secret`

Now you can use the app command to sync your local changes to your app.

`weeblybundle app /Path/To/Element/Directory`

Once you have installed your app to a site from the developer-admin, you can sync your app using weeblybundle and view your changes in the editor by refreshing the page.

Happy Bundling!

## Contributing

1. Fork it ( http://github.com/<my-github-username>/weeblybundler/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

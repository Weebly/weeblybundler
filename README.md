# WeeblyBundler

WeeblyBundler is a CLI tool created to enable Weebly Platform Developers to rapidly deploy their apps and upload their themes.

## Installing via rubygems (Recommended)

`gem install weeblybundler`

## Installing via Source

Download the source code

`git clone git@github.com:Weebly/weeblybundler.git`

Change to source directory and install dependencies (including bundler)

`cd weeblybundler`

`gem install bundler`

`bundle install`

Install the gem in your current gemset by running gem install with a path to the pkg/weeblybundler-[GEM VERSION].gem in the gem's source directory.

`gem build pkg/weeblybundler.gemspec`

`gem install pkg/weeblybundler-[GEM VERSION].gem`

Good to go!

## Usage

You use the WeeblyBundler to upload your apps or themes to Weebly, where you can test them out. The bundler uses your developer account client ID and client secret for your account to know where to upload the app to, and your email, site ID, and platform token to upload themes. These need to be set as environment variables before using the bundler. More info can be found in our developer docs, <a href="https://dev.weebly.com/githubide-development-integration.html">here</a>.

Once those are set, you run the bundler from a command line:

For apps:
`weeblybundle app /Path/To/Element/Directory`

For themes:
`weeblybundle theme /Path/To/Theme`

When run, your updated zip file is uploaded to Weebly where you can test your app or theme out. You can also use the `--watch` flag to have the bundler run whenever you update the zip file.


More info and instructions for using the bundler can be found <a href="https://dev.weebly.com/githubide-development-integration.html">here</a>.

Happy Bundling!

For developer support and questions, contact us at developer@weebly.com.

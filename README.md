# Weeblybundler

TODO: Write a gem description

## Installation

Please note, this process will be significantly easier once the gem is released on rubygems.

Download the source code

`git clone git@github.intern.weebly.net:bryan/weeblybundler.git`

Change to source directory and install dependencies

`cd /GEM/SOURCE/weeblybundler && bundle install`

Build the gem 

`rake install`

Install the gem in your current gemset 

`gem install /GEM/SOURCE/weeblybundler/pkg/weeblybundler-0.0.1.gem`

Good to go!


## Usage

To use weeblybundler, first you must set your environment variables (api token and site_id). These can be found within the weebly editor under general settings.

`export WEEBLY_TOKEN=token && export WEEBLY_SITE_ID=site_id`

Now you can use the sync command

`weeblybundle sync /Path/To/Element/Directory`


## Contributing

1. Fork it ( http://github.com/<my-github-username>/weeblybundler/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

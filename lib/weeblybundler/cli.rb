require 'thor'
require 'weeblybundler/app_bundle'
require "awesome_print"

module Weeblybundler
  class CLI < Thor

    desc "sync PATH", "Bundles and uploads your weebly platform App."
    method_options :token => :string
    method_options :site_id => :string
    def sync( path )
        token = options.token || ENV['WEEBLY_TOKEN']
        site_id = options.site_id || ENV['WEEBLY_SITE_ID']

        bundle = AppBundle.new(token, site_id, path)

    	if bundle.is_valid?
    		ap JSON.parse bundle.sync
    	else
    		ap bundle.error_message
    	end
    end

  end
end
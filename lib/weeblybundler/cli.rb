require 'thor'
require 'weeblybundler/bundle'
require "awesome_print"

module Weeblybundler
  class CLI < Thor

    desc "app PATH", "Bundles and uploads your weebly platform app."
    def app( path )
      token = ENV['WEEBLY_TOKEN']
      site_id = ENV['WEEBLY_SITE_ID']
      url = ENV['WEEBLY_DOMAIN'] || 'http://marketplace.beta.weebly.com'

      bundle = Bundle.new(token, site_id, path, url)

      if bundle.is_valid?
        response = bundle.sync('/platform/app')
        begin 
          ap JSON.parse(response)
        rescue
          ap "There was a problem uploading your element to #{url}/platform/app"
          bundle.cleanup
        end
      else
        ap bundle.errors
      end
    end

    desc "theme PATH", "Bundles and uploads your weebly platform theme."
    option :publish, :type => :boolean
    def theme( path )
      token = ENV['WEEBLY_TOKEN']
      site_id = ENV['WEEBLY_SITE_ID']
      url = ENV['WEEBLY_DOMAIN'] || 'http://marketplace.beta.weebly.com'

      bundle = Bundle.new(token, site_id, path, url)

      if bundle.is_valid?
        response = bundle.sync('/platform/theme', options[:publish])
        begin 
          ap JSON.parse(response)
        rescue
          ap "There was a problem uploading your element to #{url}/platform/theme"
          bundle.cleanup
        end
      else
        ap bundle.errors
      end
    end

  end
end
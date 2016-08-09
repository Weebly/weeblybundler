require 'thor'
require 'weeblybundler/bundle'
require "awesome_print"
require "json"

module Weeblybundler
  class CLI < Thor

    desc "app PATH", "Bundles and uploads your weebly platform app."
    def app( path )
      client_id = ENV['WEEBLY_CLIENT_ID']
      secret = ENV['WEEBLY_CLIENT_SECRET']
      url = ENV['WEEBLY_DOMAIN'] || 'https://www.weebly.com'

      bundle = Bundle.new(client_id, secret, path, url)

      if bundle.is_valid?
        response = bundle.sync('/platform/app')
        begin
          ap JSON.parse(response.body)
        rescue Exception => e
          ap "There was a problem uploading your element to #{url}/platform/app"
          ap e
          bundle.cleanup
        end
      else
        ap bundle.errors
      end
    end

    desc "theme PATH", "Bundles and uploads your weebly platform theme."
    option :publish, :type => :boolean
    def theme( path )
      client_id = ENV['WEEBLY_CLIENT_ID']
      secret = ENV['WEEBLY_CLIENT_SECRET']
      url = ENV['WEEBLY_DOMAIN'] || 'https://www.weebly.com'

      bundle = Bundle.new(client_id, secret, path, url)

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

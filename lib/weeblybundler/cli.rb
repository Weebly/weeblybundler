require 'thor'
require 'weeblybundler/bundle'
require "awesome_print"

module Weeblybundler
  class CLI < Thor

    desc "app PATH", "Bundles and uploads your weebly platform app."
    def app( path )
      token = ENV['WEEBLY_TOKEN']
      site_id = ENV['WEEBLY_SITE_ID']
      url = ENV['WEEBLY_DOMAIN'] || 'http://platform.beta.weebly.com'

      bundle = Bundle.new(token, site_id, path, url)

      if bundle.is_valid?
        response = bundle.sync
        begin 
          ap JSON.parse(response)
        rescue
          ap "There was a problem uploading your element to #{url}/element_upload_api.php"
          bundle.cleanup
        end
      else
        ap bundle.errors
      end
    end

    desc "theme PATH", "Bundles and uploads your weebly platform theme."
    def theme( path )
      token = ENV['WEEBLY_TOKEN']
      site_id = ENV['WEEBLY_SITE_ID']
      url = ENV['WEEBLY_DOMAIN'] || 'http://platform.beta.weebly.com'

      bundle = Bundle.new(token, site_id, path, url)

      if bundle.is_valid?
        response = bundle.sync
        begin 
          ap JSON.parse(response)
        rescue
          ap "There was a problem uploading your element to #{url}/element_upload_api.php"
          bundle.cleanup
        end
      else
        ap bundle.errors
      end
    end

  end
end
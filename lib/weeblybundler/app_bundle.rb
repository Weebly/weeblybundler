require 'rest_client'
require 'weeblybundler/zip_file_generator'

module Weeblybundler

  class AppBundle

    def initialize(token, site_id, path)
      @token = token
      @site_id = site_id
      @path = path
      @zip_location = "#{path}/bundle.zip"
    end

    def is_valid?
      unless File.directory?(@path)
    	  @error_message = "#{@path} is not a valid directory."
      end
      if @site_id.strip.empty?
        @error_message = "You must set your site_id in your environment variables. 'export WEEBLY_SITE_ID=123'"
      end
      if @token.strip.empty?
        @error_message = "You must set your token in your environment variables. 'export WEEBLY_TOKEN=123'"
      end

      return @error_message.nil?
    end

    def error_message
      @error_message
    end

    def sync
      zip_bundle
      response = upload
      cleanup
      return response
    end

    private

    def zip_bundle
      zfg = Weeblybundler::ZipFileGenerator.new(@path, @zip_location)
      zfg.write()
    end

    def upload
      RestClient.post('http://bryanashley.dev.weebly.net/element_upload_api.php',
    	 { :site_id => @site_id, :Filedata => File.new(@zip_location) }, 
    	 { :Authorization => @token}
      )
    end

    def cleanup
      File.delete(@zip_location)
    end
  end

end
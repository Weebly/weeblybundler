require 'rest_client'
require 'weeblybundler/zip_file_generator'

module Weeblybundler

  class Bundle

    def initialize(token, site_id, path, url)
      @token = token
      @site_id = site_id
      @path = path
      @zip_location = "#{path}/#{path.split('/').last}.zip"
      @url = url
      @errors = {}
    end

    def is_valid?
      validate
      return @errors.empty?
    end

    def errors
      @errors
    end

    def sync
      zip_bundle
      response = upload
      cleanup
      return response
    end

    def validate 
      unless File.directory?(@path)
        @errors['filepath'] = "#{@path} is not a valid directory."
      end

      if @site_id.nil? || @site_id.strip.empty?
        @errors['site id'] = "You must set your site_id in your environment variables. 'export WEEBLY_SITE_ID=123'"
      end

      if @token.nil? || @token.strip.empty?
        @errors['token'] = "You must set your token in your environment variables. 'export WEEBLY_TOKEN=123'"
      end
    end

    def cleanup
      File.delete(@zip_location) if File.exist?(@zip_location)
    end

    private

    def zip_bundle
      zfg = Weeblybundler::ZipFileGenerator.new(@path, @zip_location)
      zfg.write()
    end

    def upload
      RestClient.post("#{@url}/platform/theme",
    	 { :site_id => @site_id, :Filedata => File.new(@zip_location) }, 
    	 { :Authorization => @token}
      )
    end

  end

end
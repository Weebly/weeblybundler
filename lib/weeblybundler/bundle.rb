require 'rest_client'
require 'weeblybundler/zip_file_generator'
require 'jwt'

module Weeblybundler

  class Bundle

    def initialize(client_id, secret, path, url)
      @client_id = client_id
      @secret = secret
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

    def sync(path, publish=false)
      zip_bundle
      response = upload(path, publish)
      cleanup
      return response
    end

    def validate 
      unless File.directory?(@path)
        @errors['filepath'] = "#{@path} is not a valid directory."
      end

      if @client_id.nil? || @client_id.strip.empty?
        @errors['client_id'] = "You must set your client_id in your environment variables. You can find this id on the developer admin page. 'export WEEBLY_CLIENT_ID=123'"
      end

      if @secret.nil? || @secret.strip.empty?
        @errors['secret'] = "You must set your secret in your environment variables. 'export WEEBLY_CLIENT_SECRET=123'"
      end
    end

    def cleanup
      File.delete(@zip_location) if File.exist?(@zip_location)
    end

    private

    def zip_bundle
      zfg = Weeblybundler::ZipFileGenerator.new(@path, @zip_location)
      if (File.file?(@zip_location)) 
        File.delete(@zip_location)
      end
      zfg.write()
    end

    def upload(path, publish=false)
      token = JWT.encode({:client_id => @client_id}, @secret, 'HS256')
      RestClient.post("#{@url}#{path}",
    	 { :client_id => @client_id, :Filedata => File.new(@zip_location), :publish => publish }, 
    	 { :Authorization => token}
      )
    end

  end

end
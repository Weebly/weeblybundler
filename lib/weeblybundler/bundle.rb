require 'rest_client'
require 'weeblybundler/zip_file_generator'
require 'jwt'

module Weeblybundler

  class Bundle

    # type = ['app', 'theme']
    # path - path to the zip file.
    # domain - host to upload to.
    # params - Parameters Bundle object should be initialized with. Require parameters specified in the validateApp/validateTheme methods.

    def initialize(type, path, domain, params)
      @params = params
      @path = path
      @domain = domain
      @zip_location = "#{path}/#{path.split('/').last}.zip"
      @type = type
      @errors = {}
    end

    def is_valid?()
      unless File.directory?(@path)
        @errors['filepath'] = "#{@path} is not a valid directory."
      end

      if (@type === 'app')
        validateFields(['client_id', 'secret'])
      end
      if (@type === 'theme')
        validateFields(['site_id', 'token', 'email'])
      end
      return @errors.empty?
    end

    def validateFields(required)
      for field in required
        if @params[field].nil? || @params[field].strip.empty?
          @errors[field] = "You must set WEEBLY_" + field.upcase + " in your environment variables to upload " + @type +" '. See the ReadMe for more information."
        end
      end
    end

    def errors
      @errors
    end

    def sync(path, publish=false)
      zip_bundle
      if @type === 'app'
        response = uploadApp(path, publish)
      end
      if @type === 'theme'
        response = uploadTheme(path, publish)
      end
      cleanup
      return response
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

    def uploadApp(path, publish=false)
      token = JWT.encode({:client_id => @params['client_id']}, @params['secret'], 'HS256')
      RestClient.post("#{@domain}#{path}",
    	 { :client_id => @params['client_id'], :Filedata => File.new(@zip_location), :publish => publish }, 
    	 { :Authorization => token}
      )
    end

    def uploadTheme(path, publish=false)
      RestClient.post("#{@domain}#{path}",
       { :site_id => @params['site_id'], :email => @params['email'], :Filedata => File.new(@zip_location), :publish => publish }, 
       { :Authorization => @params['token']}
      )
    end
  end
end
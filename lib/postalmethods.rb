$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

module PostalMethods
  
  class Client

      require 'rubygems'
      gem 'soap4r'
      require 'soap/rpc/driver'
      require 'soap/wsdlDriver'

      VERBOSE=nil # soap4r is a noisy bugger  

      require 'postalmethods/exceptions.rb'
      require 'postalmethods/document_processor.rb'
      require 'postalmethods/send_letter.rb'
      require 'postalmethods/get_letter_status.rb'
      require 'postalmethods/utility.rb'

      # include modules
      include SendLetter
      include DocumentProcessor
      include GetLetterStatus
      include UtilityMethods
    
      attr_accessor :api_uri, :username, :password, :to_send, :rpc_driver, :prepared, :work_mode
  
      def initialize(opts = {})
        if opts[:username].nil? || opts[:password].nil?
          raise PostalMethods::NoCredentialsException
        end
        
        ## declare here so we can override in tests, etc.
        self.api_uri = "https://api.postalmethods.com/PostalWS.asmx?WSDL"
                
        self.username = opts[:username]
        self.password = opts[:password]
        
        if opts[:work_mode]
          set_work_mode(opts[:work_mode])
        else
          set_work_mode
        end
      end

      def prepare!
        begin
          self.rpc_driver ||= SOAP::WSDLDriverFactory.new(self.api_uri).create_rpc_driver
        rescue SocketError, RuntimeError
          raise PostalMethods::NoConnectionError
        end
        self.prepared = true
        return self
      end
      
      def set_work_mode(mode = nil)
        self.work_mode = mode.to_s.downcase
        unless mode == "production" || mode == "development"
          self.work_mode = "Default"
        end
      end
      
  end
end
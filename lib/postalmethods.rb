$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

module PostalMethods
  
  class Client
    
      require 'rubygems'
      gem 'soap4r'
      require 'soap/rpc/driver'
      require 'soap/wsdlDriver'
  
      require 'postalmethods/send_letter.rb'
      require 'postalmethods/exceptions.rb'
      require 'postalmethods/document_processor.rb'

      # include modules
      include SendLetter
      include DocumentProcessor
  
      API_URI = "http://api.postalmethods.com/PostalWS.asmx?WSDL"
  
      attr_accessor :username, :password, :to_send, :rpc_driver, :prepared
  
      def initialize(opts = {})
        if opts[:username].nil? || opts[:password].nil?
          raise PostalMethods::NoCredentialsError
        end
        
        self.username = opts[:username]
        self.password = opts[:password]
      end

      def prepare!
        self.rpc_driver = SOAP::WSDLDriverFactory.new(API_URI).create_rpc_driver
        self.prepared = true
      end
      
  end
end
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
      
      # include modules
      include SendLetter
  
      API_URI = "http://api.postalmethods.com/PostalWS.asmx?WSDL"
  
      attr_accessor :username
      attr_accessor :password
      attr_accessor :to_send
      attr_accessor :rpc_driver
  
      def initialize(opts = {})
        if opts[:username].nil? || opts[:password].nil?
          raise PostalMethods::NoCredentialsError
        end
        
        self.username = opts[:username]
        self.password = opts[:password]
      end

      def prepare!
        self.rpc_driver = SOAP::WSDLDriverFactory.new(API_URI).create_rpc_driver
      end
      
      ## document helpers
      def document=(doc)
        self.to_send = open(doc)
      end
  
      def document?
        true unless self.to_send.nil?
      end
  
      def document
        self.to_send
      end
  end
end
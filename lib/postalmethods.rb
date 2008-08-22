$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

module PostalMethods
  class Client
  
      require 'postalmethods/send_letter.rb'
  
      include SendLetter
  
      API_URI = "http://api.postalmethods.com/PostalWS.asmx?WSDL"
  
      attr_accessor :username
      attr_accessor :password
      attr_accessor :to_send
  
      def initialize(opts = {})
        # we'll need these everywhere, may as well stick them around
        self.username = opts[:username]
        self.password = opts[:password]
      end

      def prepare
    
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
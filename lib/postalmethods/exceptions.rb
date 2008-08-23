module PostalMethods
  class NoCredentialsError < Exception
    def initialize
      super("You have failed to provide any credentials")
    end
  end
  
  class NoPreparationError < Exception
    def initialize
      super("You must prepare the client first with @client.prepare!")
    end
  end
end
module PostalMethods

  class NoCredentialsException < Exception
    def initialize
      super("You have failed to provide any credentials")
    end
  end
  
  class NoPreparationException < Exception
    def initialize
      super("You must prepare the client first with @client.prepare!")
    end
  end
  
  ## base api exception - stolen from Halcyon
  ## http://github.com/mtodd/halcyon/tree/master/LICENSE
  
  class APIException < Exception
    attr_accessor :status, :body
    def initialize(status, body)
      @status = status
      @body = body
      super "[#{@status}] #{@body}"
    end
  end  
  
  API_STATUS_CODES = {
    -3000 => "OK: Successfully received the request",
    -3001 => "This user is not authorized to access the specified item",
    -3003 => "Not Authenticated",
    -3004 => "The specified extension is not supported",
    -3005 => "Rejected: no funds available",
    -3010 => "The file specified is unavailable",
    -3113 => "Rejected: the city field contains more than 30 characters",
    -3114 => "Rejected: the state field contains more than 30 characters", 
    -3115 => "There was no data returned for your query",
    -3116 => "The specified letter (ID) does not exist in the system",
    -3117 => "Rejected: the company field contains more than 45 characters",
    -3118 => "Rejected: the address1 field contains more than 45 characters",
    -3119 => "Rejected: the address2 field contains more than 45 characters",
    -3120 => "Rejected: the AttentionLine1 field contains more than 45 characters",
    -3121 => "Rejected: the AttentionLine2 field contains more than 45 characters",
    -3122 => "Rejected: the AttentionLine3 field contains more than 45 characters",
    -3150 => "General System Error: Contact technical support",
    -3500 => "Warning: too many attempts were made for this method",
    -4001 => "The username field is empty or missing",
    -4002 => "The password field is empty or missing",
    -4003 => "The MyDescription field is empty or missing - please contact support",
    -4004 => "The FileExtension field is empty or missing - please contact support",
    -4005 => "The FileBinaryData field is empty or missing - please contact support",
    -4006 => "The Address1 field is empty or missing",
    -4007 => "The city field is empty or missing",
    -4008 => "The Attention1 or Company fields are empty or missing",
    -4009 => "The ID field is empty or missing.",
    -4010 => "The MinID field is empty or missing",
    -4011 => "The MaxID field is empty or missing",
  }
  
  
  #--
  # Classify Status Codes
  #++
  
  API_STATUS_CODES.to_a.each do |http_status|
    status, body = http_status
    class_eval <<-"end;"
      class APIStatusCode#{status.to_s.gsub(/( |\-)/,'')} < PostalMethods::APIException
        def initialize(body=nil)
          body = '#{body}' if body.nil?
          super(#{status}, body)
        end
      end
    end;
  end
  
  
end
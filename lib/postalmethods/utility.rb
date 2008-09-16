module PostalMethods
  
  module UtilityMethods
    
    require 'base64'
   
    def get_letter_details(id)
      raise PostalMethods::NoPreparationException unless self.prepared 
      
      ## get a letter as pdf over the wire
      rv = @rpc_driver.getLetterDetails(:Username => self.username, :Password => self.password, :ID => id) 
      
      status_code = rv.getLetterDetailsResult.resultCode.to_i
      letter_data = rv.getLetterDetailsResult
            
      if status_code == -3000 # successfully received the req
        return [letter_data, status_code]
      elsif API_STATUS_CODES.has_key?(status_code)
        instance_eval("raise APIStatusCode#{status_code.to_s.gsub(/( |\-)/,'')}Exception")
      end
      raise PostalMethods::GenericCodeError
    end
    
    def get_pdf(id)
      raise PostalMethods::NoPreparationException unless self.prepared 
      
      ## get a letter as pdf over the wire
      begin
        rv = @rpc_driver.getPDF(:Username => self.username, :Password => self.password, :ID => id)
      rescue SOAP::FaultError
        raise APIStatusCode3150Exception
      end
            
      status_code = rv.getPDFResult.resultCode.to_i

      if status_code == -3000 # successfully received the req
        return Base64.decode64(rv.getPDFResult.fileData) # the data returned is base64...
      elsif API_STATUS_CODES.has_key?(status_code)
        instance_eval("raise APIStatusCode#{status_code.to_s.gsub(/( |\-)/,'')}Exception")
      end
      raise PostalMethods::GenericCodeError
    end
    
    def cancel_delivery(id)
       raise PostalMethods::NoPreparationException unless self.prepared 
       
       ## get a letter as pdf over the wire
       rv = @rpc_driver.cancelDelivery(:Username => self.username, :Password => self.password, :ID => id)
       
       status_code = rv.cancelDeliveryResult.to_i
      
       if status_code == -3000 # successfully received the req
         return true
       elsif API_STATUS_CODES.has_key?(status_code)
         instance_eval("raise APIStatusCode#{status_code.to_s.gsub(/( |\-)/,'')}Exception")
       end
       raise PostalMethods::GenericCodeError
    end
  end
end
module PostalMethods
  
  module GetLetterStatus
    
    def get_letter_status(id)
      raise PostalMethods::NoPreparationException unless self.prepared 

      ## get status
      opts = {:Username => self.username, :Password => self.password, :ID => id}
      
      rv = @rpc_driver.getLetterStatus(opts)

      puts rv
      puts rv.inspect
      
            ws_status = rv.getLetterStatusResult.resultCode.to_i
      delivery_status = rv.getLetterStatusResult.status.to_i
          last_status = rv.getLetterStatusResult.lastUpdateTime
      
      if ws_status == -3000
        return [delivery_status, last_status, ws_status]
      elsif API_STATUS_CODES.has_key?(ws_status)
        instance_eval("raise APIStatusCode#{status_code.to_s.gsub(/( |\-)/,'')}Exception")
      end

    end
    
  end
end
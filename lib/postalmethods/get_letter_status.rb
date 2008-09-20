module PostalMethods
  
  module GetLetterStatus
    
    def get_letter_status(id)
      raise PostalMethods::NoPreparationException unless self.prepared 

      ## get status
      opts = {:Username => self.username, :Password => self.password, :ID => id}
      
      rv = @rpc_driver.getLetterStatus(opts)
      
            ws_status = rv.getLetterStatusResult.resultCode.to_i
      delivery_status = rv.getLetterStatusResult.status.to_i
          last_update = rv.getLetterStatusResult.lastUpdateTime
      
      if ws_status == -3000
        return [delivery_status, last_update]
      elsif API_STATUS_CODES.has_key?(ws_status)
        instance_eval("raise APIStatusCode#{ws_status.to_s.gsub(/( |\-)/,'')}Exception")
      end

    end

    def get_letter_status_multiple(ids)
      raise PostalMethods::NoPreparationException unless self.prepared

      if ids.class == Array
        ids = ids.join(",")
      end
      
      # minimal input checking - let api take care of it
      return PostalMethods::InvalidLetterIDsRange unless ids.class == String

      ## get status
      opts = {:Username => self.username, :Password => self.password, :ID => ids}
      
      rv = @rpc_driver.getLetterStatus_Multiple(opts)
      
      ws_status = rv.getLetterStatus_MultipleResult.resultCode.to_i
      
      if ws_status == -3000
        return rv.getLetterStatus_MultipleResult.letterStatuses.letterStatus
      elsif API_STATUS_CODES.has_key?(ws_status)
        instance_eval("raise APIStatusCode#{ws_status.to_s.gsub(/( |\-)/,'')}Exception")
      end

    end

    def get_letter_status_range(minid, maxid)
      raise PostalMethods::NoPreparationException unless self.prepared 

      ## get status
      opts = {:Username => self.username, :Password => self.password, :MinID => minid.to_i, :MaxID => maxid.to_i}
      
      rv = @rpc_driver.getLetterStatus_Range(opts)

      ws_status = rv.getLetterStatus_RangeResult.resultCode.to_i
      
      if ws_status == -3000
        return rv.getLetterStatus_RangeResult.letterStatuses.letterStatus
      elsif API_STATUS_CODES.has_key?(ws_status)
        instance_eval("raise APIStatusCode#{ws_status.to_s.gsub(/( |\-)/,'')}Exception")
      end

    end
    
  end
end
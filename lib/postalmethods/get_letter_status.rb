module PostalMethods
  module GetLetterStatus

    def get_letter_status(id)
      raise PostalMethods::NoPreparationException unless self.prepared

      ## get status
      opts = {:Username => self.username, :Password => self.password, :api_key => ENV['POSTAL_METHODS_API_KEY'], :ID => id}

      rv = @rpc_driver.getLetterStatusV2(opts)

            ws_status = rv.getLetterStatusV2Result.resultCode.to_i
      delivery_status = rv.getLetterStatusV2Result.status.to_i
          last_update = rv.getLetterStatusV2Result.lastUpdateTime

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
      opts = {:Username => self.username, :Password => self.password, :api_key => ENV['POSTAL_METHODS_API_KEY'], :ID => ids}

      rv = @rpc_driver.getLetterStatusV2_Multiple(opts)
      ws_status = rv.getLetterStatusV2_MultipleResult.resultCode.to_i

      if ws_status == -3000
        return rv.getLetterStatusV2_MultipleResult.letterStatuses.letterStatusAndDesc
      elsif API_STATUS_CODES.has_key?(ws_status)
        instance_eval("raise APIStatusCode#{ws_status.to_s.gsub(/( |\-)/,'')}Exception")
      end

    end

    def get_letter_status_range(minid, maxid)
      raise PostalMethods::NoPreparationException unless self.prepared

      ## get status
      opts = {:Username => self.username, :Password => self.password, :api_key => ENV['POSTAL_METHODS_API_KEY'], :MinID => minid.to_i, :MaxID => maxid.to_i}

      rv = @rpc_driver.getLetterStatusV2_Range(opts)

      ws_status = rv.getLetterStatusV2_RangeResult.resultCode.to_i

      if ws_status == -3000
        return rv.getLetterStatusV2_RangeResult.letterStatuses.letterStatusAndDesc
      elsif API_STATUS_CODES.has_key?(ws_status)
        instance_eval("raise APIStatusCode#{ws_status.to_s.gsub(/( |\-)/,'')}Exception")
      end
    end
  end
end

module PostalMethods

  module SendLetter

    def send_letter(doc, description, work_mode = "")
      raise PostalMethods::NoPreparationException unless self.prepared
      ## push a letter over the api



      self.document = doc
      rv = @rpc_driver.sendLetterV2(:Username => self.username, :Password => self.password, :api_key => ENV['POSTAL_METHODS_API_KEY'], :FileExtension => self.document[:extension],
                                  :FileBinaryData => self.document[:bytes], :MyDescription => description, :WorkMode => self.work_mode)

      status_code = rv.sendLetterV2Result.to_i

      if status_code > 0
        return status_code
      elsif API_STATUS_CODES.has_key?(status_code)
        instance_eval("raise APIStatusCode#{status_code.to_s.gsub(/( |\-)/,'')}Exception")
      end
    end

    def send_letter_with_address(doc, description, address)
      raise PostalMethods::NoPreparationException unless self.prepared
      raise PostalMethods::AddressNotHashException unless (address.class == Hash)

      ## setup the document
      self.document = doc

      opts = {:Username => self.username, :Password => self.password, :api_key => ENV['POSTAL_METHODS_API_KEY'], :FileExtension => self.document[:extension],
                                  :FileBinaryData => self.document[:bytes], :MyDescription => description, :WorkMode => self.work_mode}

      opts.merge!(address)

      ## push a letter over the api
      rv = @rpc_driver.sendLetterAndAddressV2(opts)
      status_code = rv.sendLetterAndAddressV2Result.to_i

      if status_code > 0
        return status_code
      elsif API_STATUS_CODES.has_key?(status_code)
        instance_eval("raise APIStatusCode#{status_code.to_s.gsub(/( |\-)/,'')}Exception")
      end
    end

  end

end

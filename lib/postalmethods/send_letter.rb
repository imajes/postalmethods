module PostalMethods
  
  module SendLetter
    
    def send_letter(doc, description="")
      raise PostalMethods::NoPreparationException unless self.prepared 
      ## push a letter over the api
      self.document = doc
      rv = @rpc_driver.sendLetter(:Username => self.username, :Password => self.password, :FileExtension => self.document[:extension], 
                                  :FileBinaryData => self.document[:bytes], :MyDescription => description)
      
      
    end
    
  end
  
end
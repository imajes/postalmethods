module PostalMethods
  
  module SendLetter
    
    def send_letter(doc, description="")
      raise PostalMethods::NoPreparationError unless self.prepared 
      ## push a letter over the api
      self.document = doc
      @rpc_driver.sendLetter(:Username => self.username, :Password => self.password, :MyDocument => document, :MyDescription => description)
    end
    
  end
  
end
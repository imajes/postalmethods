require 'xsd/qname'

# {PostalMethods}GetLetterStatusResult
#   resultCode - SOAP::SOAPInt
#   status - SOAP::SOAPInt
#   lastUpdateTime - SOAP::SOAPDateTime
class GetLetterStatusResult
  attr_accessor :resultCode
  attr_accessor :status
  attr_accessor :lastUpdateTime

  def initialize(resultCode = nil, status = nil, lastUpdateTime = nil)
    @resultCode = resultCode
    @status = status
    @lastUpdateTime = lastUpdateTime
  end
end

# {PostalMethods}GetLetterStatus_MultipleResult
#   resultCode - SOAP::SOAPInt
#   letterStatuses - ArrayOfLetterStatus
class GetLetterStatus_MultipleResult
  attr_accessor :resultCode
  attr_accessor :letterStatuses

  def initialize(resultCode = nil, letterStatuses = nil)
    @resultCode = resultCode
    @letterStatuses = letterStatuses
  end
end

# {PostalMethods}ArrayOfLetterStatus
class ArrayOfLetterStatus < ::Array
end

# {PostalMethods}LetterStatus
#   iD - SOAP::SOAPInt
#   status - SOAP::SOAPInt
#   lastUpdateTime - SOAP::SOAPDateTime
class LetterStatus
  attr_accessor :iD
  attr_accessor :status
  attr_accessor :lastUpdateTime

  def initialize(iD = nil, status = nil, lastUpdateTime = nil)
    @iD = iD
    @status = status
    @lastUpdateTime = lastUpdateTime
  end
end

# {PostalMethods}GetLetterStatus_RangeResult
#   resultCode - SOAP::SOAPInt
#   letterStatuses - ArrayOfLetterStatus
class GetLetterStatus_RangeResult
  attr_accessor :resultCode
  attr_accessor :letterStatuses

  def initialize(resultCode = nil, letterStatuses = nil)
    @resultCode = resultCode
    @letterStatuses = letterStatuses
  end
end

# {PostalMethods}GetLetterDetailsResult
#   resultCode - SOAP::SOAPInt
#   iD - SOAP::SOAPInt
#   price - SOAP::SOAPDecimal
#   numOfSheets - SOAP::SOAPInt
#   submitTime - SOAP::SOAPDateTime
#   completionTime - SOAP::SOAPDateTime
#   orientation - SOAP::SOAPString
#   envelope - SOAP::SOAPString
#   paper - SOAP::SOAPString
#   printColor - SOAP::SOAPString
#   printSides - SOAP::SOAPString
#   nationalMailing - SOAP::SOAPString
#   internationalMailing - SOAP::SOAPString
class GetLetterDetailsResult
  attr_accessor :resultCode
  attr_accessor :iD
  attr_accessor :price
  attr_accessor :numOfSheets
  attr_accessor :submitTime
  attr_accessor :completionTime
  attr_accessor :orientation
  attr_accessor :envelope
  attr_accessor :paper
  attr_accessor :printColor
  attr_accessor :printSides
  attr_accessor :nationalMailing
  attr_accessor :internationalMailing

  def initialize(resultCode = nil, iD = nil, price = nil, numOfSheets = nil, submitTime = nil, completionTime = nil, orientation = nil, envelope = nil, paper = nil, printColor = nil, printSides = nil, nationalMailing = nil, internationalMailing = nil)
    @resultCode = resultCode
    @iD = iD
    @price = price
    @numOfSheets = numOfSheets
    @submitTime = submitTime
    @completionTime = completionTime
    @orientation = orientation
    @envelope = envelope
    @paper = paper
    @printColor = printColor
    @printSides = printSides
    @nationalMailing = nationalMailing
    @internationalMailing = internationalMailing
  end
end

# {PostalMethods}GetPDFResult
#   resultCode - SOAP::SOAPInt
#   fileData - SOAP::SOAPBase64
class GetPDFResult
  attr_accessor :resultCode
  attr_accessor :fileData

  def initialize(resultCode = nil, fileData = nil)
    @resultCode = resultCode
    @fileData = fileData
  end
end

# {PostalMethods/AbstractTypes}StringArray
class StringArray < ::Array
end

# {PostalMethods}SendLetter
#   username - SOAP::SOAPString
#   password - SOAP::SOAPString
#   myDescription - SOAP::SOAPString
#   fileExtension - SOAP::SOAPString
#   fileBinaryData - SOAP::SOAPBase64
class SendLetter
  attr_accessor :username
  attr_accessor :password
  attr_accessor :myDescription
  attr_accessor :fileExtension
  attr_accessor :fileBinaryData

  def initialize(username = nil, password = nil, myDescription = nil, fileExtension = nil, fileBinaryData = nil)
    @username = username
    @password = password
    @myDescription = myDescription
    @fileExtension = fileExtension
    @fileBinaryData = fileBinaryData
  end
end

# {PostalMethods}SendLetterResponse
#   sendLetterResult - SOAP::SOAPInt
class SendLetterResponse
  attr_accessor :sendLetterResult

  def initialize(sendLetterResult = nil)
    @sendLetterResult = sendLetterResult
  end
end

# {PostalMethods}SendLetterAndAddress
#   username - SOAP::SOAPString
#   password - SOAP::SOAPString
#   myDescription - SOAP::SOAPString
#   fileExtension - SOAP::SOAPString
#   fileBinaryData - SOAP::SOAPBase64
#   attentionLine1 - SOAP::SOAPString
#   attentionLine2 - SOAP::SOAPString
#   attentionLine3 - SOAP::SOAPString
#   company - SOAP::SOAPString
#   address1 - SOAP::SOAPString
#   address2 - SOAP::SOAPString
#   city - SOAP::SOAPString
#   state - SOAP::SOAPString
#   postalCode - SOAP::SOAPString
#   country - SOAP::SOAPString
class SendLetterAndAddress
  attr_accessor :username
  attr_accessor :password
  attr_accessor :myDescription
  attr_accessor :fileExtension
  attr_accessor :fileBinaryData
  attr_accessor :attentionLine1
  attr_accessor :attentionLine2
  attr_accessor :attentionLine3
  attr_accessor :company
  attr_accessor :address1
  attr_accessor :address2
  attr_accessor :city
  attr_accessor :state
  attr_accessor :postalCode
  attr_accessor :country

  def initialize(username = nil, password = nil, myDescription = nil, fileExtension = nil, fileBinaryData = nil, attentionLine1 = nil, attentionLine2 = nil, attentionLine3 = nil, company = nil, address1 = nil, address2 = nil, city = nil, state = nil, postalCode = nil, country = nil)
    @username = username
    @password = password
    @myDescription = myDescription
    @fileExtension = fileExtension
    @fileBinaryData = fileBinaryData
    @attentionLine1 = attentionLine1
    @attentionLine2 = attentionLine2
    @attentionLine3 = attentionLine3
    @company = company
    @address1 = address1
    @address2 = address2
    @city = city
    @state = state
    @postalCode = postalCode
    @country = country
  end
end

# {PostalMethods}SendLetterAndAddressResponse
#   sendLetterAndAddressResult - SOAP::SOAPInt
class SendLetterAndAddressResponse
  attr_accessor :sendLetterAndAddressResult

  def initialize(sendLetterAndAddressResult = nil)
    @sendLetterAndAddressResult = sendLetterAndAddressResult
  end
end

# {PostalMethods}GetLetterStatus
#   username - SOAP::SOAPString
#   password - SOAP::SOAPString
#   iD - SOAP::SOAPInt
class GetLetterStatus
  attr_accessor :username
  attr_accessor :password
  attr_accessor :iD

  def initialize(username = nil, password = nil, iD = nil)
    @username = username
    @password = password
    @iD = iD
  end
end

# {PostalMethods}GetLetterStatusResponse
#   getLetterStatusResult - GetLetterStatusResult
class GetLetterStatusResponse
  attr_accessor :getLetterStatusResult

  def initialize(getLetterStatusResult = nil)
    @getLetterStatusResult = getLetterStatusResult
  end
end

# {PostalMethods}GetLetterStatus_Multiple
#   username - SOAP::SOAPString
#   password - SOAP::SOAPString
#   iD - SOAP::SOAPString
class GetLetterStatus_Multiple
  attr_accessor :username
  attr_accessor :password
  attr_accessor :iD

  def initialize(username = nil, password = nil, iD = nil)
    @username = username
    @password = password
    @iD = iD
  end
end

# {PostalMethods}GetLetterStatus_MultipleResponse
#   getLetterStatus_MultipleResult - GetLetterStatus_MultipleResult
class GetLetterStatus_MultipleResponse
  attr_accessor :getLetterStatus_MultipleResult

  def initialize(getLetterStatus_MultipleResult = nil)
    @getLetterStatus_MultipleResult = getLetterStatus_MultipleResult
  end
end

# {PostalMethods}GetLetterStatus_Range
#   username - SOAP::SOAPString
#   password - SOAP::SOAPString
#   minID - SOAP::SOAPInt
#   maxID - SOAP::SOAPInt
class GetLetterStatus_Range
  attr_accessor :username
  attr_accessor :password
  attr_accessor :minID
  attr_accessor :maxID

  def initialize(username = nil, password = nil, minID = nil, maxID = nil)
    @username = username
    @password = password
    @minID = minID
    @maxID = maxID
  end
end

# {PostalMethods}GetLetterStatus_RangeResponse
#   getLetterStatus_RangeResult - GetLetterStatus_RangeResult
class GetLetterStatus_RangeResponse
  attr_accessor :getLetterStatus_RangeResult

  def initialize(getLetterStatus_RangeResult = nil)
    @getLetterStatus_RangeResult = getLetterStatus_RangeResult
  end
end

# {PostalMethods}GetLetterDetails
#   username - SOAP::SOAPString
#   password - SOAP::SOAPString
#   iD - SOAP::SOAPInt
class GetLetterDetails
  attr_accessor :username
  attr_accessor :password
  attr_accessor :iD

  def initialize(username = nil, password = nil, iD = nil)
    @username = username
    @password = password
    @iD = iD
  end
end

# {PostalMethods}GetLetterDetailsResponse
#   getLetterDetailsResult - GetLetterDetailsResult
class GetLetterDetailsResponse
  attr_accessor :getLetterDetailsResult

  def initialize(getLetterDetailsResult = nil)
    @getLetterDetailsResult = getLetterDetailsResult
  end
end

# {PostalMethods}GetPDF
#   username - SOAP::SOAPString
#   password - SOAP::SOAPString
#   iD - SOAP::SOAPInt
class GetPDF
  attr_accessor :username
  attr_accessor :password
  attr_accessor :iD

  def initialize(username = nil, password = nil, iD = nil)
    @username = username
    @password = password
    @iD = iD
  end
end

# {PostalMethods}GetPDFResponse
#   getPDFResult - GetPDFResult
class GetPDFResponse
  attr_accessor :getPDFResult

  def initialize(getPDFResult = nil)
    @getPDFResult = getPDFResult
  end
end

# {PostalMethods}CancelDelivery
#   username - SOAP::SOAPString
#   password - SOAP::SOAPString
#   iD - SOAP::SOAPInt
class CancelDelivery
  attr_accessor :username
  attr_accessor :password
  attr_accessor :iD

  def initialize(username = nil, password = nil, iD = nil)
    @username = username
    @password = password
    @iD = iD
  end
end

# {PostalMethods}CancelDeliveryResponse
#   cancelDeliveryResult - SOAP::SOAPInt
class CancelDeliveryResponse
  attr_accessor :cancelDeliveryResult

  def initialize(cancelDeliveryResult = nil)
    @cancelDeliveryResult = cancelDeliveryResult
  end
end

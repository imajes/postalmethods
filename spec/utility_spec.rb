require File.dirname(__FILE__) + '/spec_helper.rb'
require 'base64'

describe "Utility Methods" do
  
  before :each do
    @doc = open(File.dirname(__FILE__) + '/../doc/sample.pdf')
    @client = PostalMethods::Client.new(PM_OPTS)
    @client.prepare!
  end
  
  it "Should get a pdf returned for a file sent" do
    rv = @client.get_pdf(1023117) ## use known static / magic file. sucks, but what can you do?
    rv.length.should == 49606
    f = open("test_output.pdf", "w")
    
    f.write(rv)
    (`file test_output.pdf`).should == "test_output.pdf: PDF document, version 1.3\n"
    system("rm test_output.pdf")
  end
  
  it "should check for error for when there is no file yet" do
    res = @client.send_letter(@doc, "the long goodbye")
    id = res.sendLetterResult.to_i
    
    id.should > 0
    
    # this should switch to a -3005 error once implemented at the api...
    lambda {@client.get_pdf(id)}.should raise_error(PostalMethods::APIStatusCode3150Exception)
  end
  
  it "should get the details of a letter" do
    id = @client.send_letter(@doc, "the long goodbye").sendLetterResult.to_i
    details = @client.get_letter_details(id).first
    details.should be_an_instance_of(SOAP::Mapping::Object)
    
    details.price.should == "0.00"
    details.iD.to_i.should == id ## be careful not to confuse with class id
  end
  
  it "should raise an error when trying to get details of an invalid letter" do
    sleep(6) # got to wait 6 seconds...
    lambda { rv = @client.get_letter_details(1)}.should raise_error(PostalMethods::APIStatusCode3001Exception)
  end
  
  it "should cancel delivery of a letter" do
    id = @client.send_letter(@doc, "the long goodbye").sendLetterResult.to_i

    rv = @client.cancel_delivery(id)
    rv.should be_true  
  end
  
  it "should raise an error when trying to get details of an invalid letter" do
    lambda { rv = @client.cancel_delivery(1)}.should raise_error(PostalMethods::APIStatusCode3001Exception)
  end
  
  
end
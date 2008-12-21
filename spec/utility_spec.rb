require File.dirname(__FILE__) + '/spec_helper.rb'
require 'base64'

describe "Utility Methods" do
  
  before :each do
    @doc = open(File.dirname(__FILE__) + '/../spec/doc/sample.pdf')
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
    id = @client.send_letter(@doc, "the long goodbye")
    id.should > 0
    lambda {@client.get_pdf(id)}.should raise_error(PostalMethods::APIStatusCode3020Exception)
  end
  
  it "should get the details of a letter" do
    id = @client.send_letter(@doc, "the long goodbye").to_i
    sleep(10) # because it's a tired little clients
    details = @client.get_letter_details(id)
    
    # check the return...
    details.should be_an_instance_of(Array)
    
    # and now the item...
    details.first.should be_an_instance_of(SOAP::Mapping::Object)
    
    details.first.price.should == "0.00"
    details.first.iD.to_i.should == id ## be careful not to confuse with class id
    details.last.should be_a_kind_of(String)
    details.last.should == "Development"
  end
  
  it "should raise a letter does not exist (3116) error when trying to get details of an invalid letter" do
    sleep(6) # got to wait 6 seconds...
    lambda { @client.get_letter_details(1)}.should raise_error(PostalMethods::APIStatusCode3116Exception)
  end
  
  it "should cancel delivery of a letter" do
    id = @client.send_letter(@doc, "the long goodbye")
    rv = @client.cancel_delivery(id)
    rv.should be_true  
  end
  
  it "should raise a letter does not exist (3116) error when trying to cancel an invalid letter" do
    lambda { @client.cancel_delivery(1)}.should raise_error(PostalMethods::APIStatusCode3116Exception)
  end
  
  
end
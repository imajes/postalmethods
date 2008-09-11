require File.dirname(__FILE__) + '/spec_helper.rb'

describe "Utility Methods" do
  
  before :each do
    @doc = open(File.dirname(__FILE__) + '/../doc/sample.pdf')
    @client = PostalMethods::Client.new(PM_OPTS)
    #@client.expects(:rpc_driver).returns(SOAP::WSDLDriverFactory)
    @client.prepare!
  end
  
  it "Should get a pdf returned for a file sent" do
    ##setup - mock already tested objects
    rv = @client.get_pdf(1023117)
    rv.length.should == 66224
    File.write("test_output.pdf", rv.read)
    lambda {`file foo`}
  end
  
  it "should check for error for when there is no file yet" do
    res = @client.send_letter(@doc, "the long goodbye")
    id = res.sendLetterResult.to_i
    
    id.should > 0
    rv = @client.get_pdf(id)
    
    
  end
  
end
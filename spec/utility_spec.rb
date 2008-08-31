require File.dirname(__FILE__) + '/spec_helper.rb'

describe "Utility Methods" do
  
  before :each do
    @doc = open(File.dirname(__FILE__) + '/../doc/sample.pdf')
    @client = PostalMethods::Client.new(PM_OPTS)
    @client.expects(:rpc_driver).returns(SOAP::WSDLDriverFactory)
    @client.prepare!
  end
  
  it "Should get the same pdf for a file as was sent" do
    ##setup - mock already tested objects
    @client.expects(:send_letter).returns(Class)
    res = @client.send_letter(@doc, "the long goodbye")
    res.expects(:sendLetterResult).returns("123")
    id = res.sendLetterResult.to_i

    ## setup done, lets spec
    id.should > 0
    rv = @client.get_pdf(id)
    rv.length.should == @doc.length
  end
  
end
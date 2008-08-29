require File.dirname(__FILE__) + '/spec_helper.rb'

describe "Utility Methods" do
  
  before :each do
    @doc = open(File.dirname(__FILE__) + '/../doc/sample.pdf')
    @client = PostalMethods::Client.new(PM_OPTS)
    @client.prepare!
  end
  
  it "Should get the same pdf for a file as was sent" do
    res = @client.send_letter(@doc, "the long goodbye").sendLetterResult.to_i
    res.should > 0
    
    rv = @client.get_pdf(res)
    
    rv.length.should == @doc.length
    
  end
  
end
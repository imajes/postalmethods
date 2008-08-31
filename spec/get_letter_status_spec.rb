require File.dirname(__FILE__) + '/spec_helper.rb'

describe "Get Letter Status" do
  
  before :each do
    @doc = open(File.dirname(__FILE__) + '/../doc/sample.pdf')
    @client = PostalMethods::Client.new(PM_OPTS)
    @client.prepare!
  end
  
  it "should send a letter and get status" do
    rv = @client.send_letter(@doc, "the long goodbye").sendLetterResult
    rv.to_i.should > 0
    
    @client.get_letter_status(id).to_i.should == -900
    
  end
  

  
end

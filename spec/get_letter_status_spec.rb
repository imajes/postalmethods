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
  
  it "should send multiple letters and get their status" do

    letters = []
    1.upto(3) do
      rv = @client.send_letter(@doc, "the long goodbye").sendLetterResult
      rv.to_i.should > 0
      letters << rv
    end
    
    ret = @client.get_letter_status_multiple(letters)
    ret.should be_an_instance_of(Array)
    
    
  end

  
end

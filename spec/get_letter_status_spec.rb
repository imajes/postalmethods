require File.dirname(__FILE__) + '/spec_helper.rb'

describe "Get Letter Status" do
  
  before :each do
    @doc = open(File.dirname(__FILE__) + '/../doc/sample.pdf')
    @client = PostalMethods::Client.new(PM_OPTS)
    @client.prepare!
  end
  
  it "should send a letter and get status" do
    ## use a static known good id that has gone thru in dev mode
    @client.get_letter_status(1023577).first.to_i.should == -1002
  end
  
  it "should send multiple letters and get their status" do
    letters = []
    1.upto(3) do
      @doc = open(File.dirname(__FILE__) + '/../doc/sample.pdf')
      @client = PostalMethods::Client.new(PM_OPTS)
      @client.prepare!
      rv = @client.send_letter(@doc, "the long goodbye").sendLetterResult
      rv.to_i.should > 0
      letters << rv
      sleep(6) #stupid api
    end
    
    ret = @client.get_letter_status_multiple(letters)
    ret.should be_an_instance_of(Array)
    
    recv_letters = ret.collect { |r| r.iD }

    recv_letters.should == letters
    
  end

  
end

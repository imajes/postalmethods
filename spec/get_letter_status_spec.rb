require File.dirname(__FILE__) + '/spec_helper.rb'

describe "Get Letter Status" do
  
  before :each do
    @doc = open(File.dirname(__FILE__) + '/../spec/doc/sample.pdf')
    @client = PostalMethods::Client.new(PM_OPTS)
    @client.prepare!
    sleep(10)
  end
  
  it "should send a letter and get status" do
    ## use a static known good id that has gone thru in dev mode
    f = @client.get_letter_status(1023577)
    f.length.should == 2
    f.first.to_i.should == -1002
  end
  
  it "should try to get status of a letter i don't have access to" do
    # FIXME: this is a bad test as it doesn't really prove what we're trying to. 
    # much better to have a different user make a new post etc..
    lambda { @client.get_letter_status(1020000)}.should raise_error(PostalMethods::APIStatusCode3116Exception)
  end
  
  
  it "should send multiple letters and get their status" do
    letters = []
    1.upto(3) do
      @doc = open(File.dirname(__FILE__) + '/../spec/doc/sample.pdf')
      @client = PostalMethods::Client.new(PM_OPTS)
      @client.prepare!
      rv = @client.send_letter(@doc, "the long goodbye")
      rv.should > 0
      letters << rv
      #sleep(10) # api needs some time
    end
    
    ret = @client.get_letter_status_multiple(letters)
    ret.should be_an_instance_of(Array)
    
    # the return is an array [results, status]
    recv_letters = ret.collect { |r| r.iD.to_i }
  
    recv_letters.should == letters
  end

  it "should attempt to request a multiple array of invalid letters" do
    lambda { @client.get_letter_status_multiple([1,2,3]) }.should raise_error(PostalMethods::APIStatusCode3115Exception)
  end

  it "should request a range of letters and get their status" do
    letters = []
    1.upto(3) do
      @doc = open(File.dirname(__FILE__) + '/../spec/doc/sample.pdf')
      @client = PostalMethods::Client.new(PM_OPTS)
      @client.prepare!      
      rv = @client.send_letter(@doc, "the long goodbye")
      rv.should > 0
      letters << rv
      #sleep(10) # api needs some time
    end
    
    ret = @client.get_letter_status_range(letters.first, letters.last)
    ret.should be_an_instance_of(Array)
    
    # the return is an array [results, status]
    recv_letters = ret.collect { |r| r.iD.to_i }

    recv_letters.should == letters
  end

  it "should attempt to request a range of invalid letters" do
    lambda { @client.get_letter_status_range(1,3) }.should raise_error(PostalMethods::APIStatusCode3115Exception)
  end

end

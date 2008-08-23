require File.dirname(__FILE__) + '/spec_helper.rb'

describe "Basic Client" do
  
  it "should instantiate a client with a username and password" do
    c = PostalMethods::Client.new(PM_OPTS)
    c.class.should == PostalMethods::Client
  end
  
  it "should fail without a user/pass on instantiation" do
    lambda {PostalMethods::Client.new()}.should raise_error(PostalMethods::NoCredentialsError)
  end
  
  it "should create a driver client thru the factory" do
    c = PostalMethods::Client.new(PM_OPTS)
    c.prepare!
    c.rpc_driver.class.should == SOAP::RPC::Driver
  end
end


describe "Send Letter" do
  
  before :each do
    @doc = open(File.dirname(__FILE__) + '/../doc/sample.pdf')
    @client = PostalMethods::Client.new(PM_OPTS)
  end
  
  it "should instantiate and send a letter" do
    @client.prepare!
    rv = @client.send_letter(@doc, "the long goodbye")
    puts rv
    puts rv.inspect
  end
  
  it "should refuse to send letter before prepare" do
    lambda {@client.send_letter(@doc, "the long goodbye")}.should raise_error(PostalMethods::NoPreparationError)
  end  
end

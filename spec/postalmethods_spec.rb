require File.dirname(__FILE__) + '/spec_helper.rb'

describe "Basic Client" do
  
  it "should instantiate a client with a username and password" do
    c = PostalMethods::Client.new(:username => 'test', :password => 'pass')
    c.class.should == PostalMethods::Client
  end
  
  it "should fail without a user/pass on instantiation" do
    lambda {PostalMethods::Client.new()}.should raise_error(PostalMethods::NoCredentialsError)
  end
  
  it "should create a driver client thru the factory" do
    c = PostalMethods::Client.new(:username => 'test', :password => 'pass')
    c.prepare!
    c.rpc_driver.class.should == SOAP::RPC::Driver
  end
end


describe "Send Letter" do
  
  before :each do
    @client = PostalMethods::Client.new(:username => 'user', :password => 'thepass')
  end
  
  it "should instantiate and find the client settings" do
    doc = open(File.dirname(__FILE__) + '/../doc/sample.pdf')
     rv = @client.send_letter(doc, "the long goodbye")
    
  end
  
end

require File.dirname(__FILE__) + '/spec_helper.rb'

describe "Client" do
  
  it "should instantiate a client with a username and password" do
    c = PostalMethods::Client.new(PM_OPTS)
    c.class.should == PostalMethods::Client
  end
  
  it "should fail without a user/pass on instantiation" do
    lambda {PostalMethods::Client.new()}.should raise_error(PostalMethods::NoCredentialsException)
  end
  
  it "should create a driver client thru the factory" do
    c = PostalMethods::Client.new(PM_OPTS)
    c.prepare!
    c.rpc_driver.class.should == SOAP::RPC::Driver
  end
end

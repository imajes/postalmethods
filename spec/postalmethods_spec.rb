require File.dirname(__FILE__) + '/spec_helper.rb'

describe "Basic Client" do
  
  it "should instantiate a client with a username and password" do
    c = PostalMethods::Client.new(:user => 'user', :password => 'password')
    c.class.should == PostalMethods::Client
  end
  
  it "should fail without a user/pass on instantiation"
  
  it ""
  
end


describe "Send Letter" do
  
  before :each do
    @client = PostalMethods::Client.new(:user => 'user', :password => 'thepass')
  end
  
  it "should instantiate and find the client settings" do
    
    @client.send_letter("goo","gunk")
    
  end
  
end

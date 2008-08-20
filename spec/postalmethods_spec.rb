require File.dirname(__FILE__) + '/spec_helper.rb'

describe "Postal Methods Basic Client" do
  
  it "should instantiate a client with a username and password" do
    c = PostalMethods::Client.new(:user => 'user', :password => 'password')
    c.class.should == PostalMethods::Client
  end
  
  it "should fail without a user/pass on instantiation"
  
  it ""
  
end

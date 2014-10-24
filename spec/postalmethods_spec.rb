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
    VCR.use_cassette('client/prepare') do
      c.prepare!
    end
    c.rpc_driver.class.should == SOAP::RPC::Driver
  end

  it "should raise a connection error exception when the api is unreachable" do
    wsdl_driver_factory = double(:wsdl_driver_factory)
    SOAP::WSDLDriverFactory.stub(:new).and_return(wsdl_driver_factory)
    allow(wsdl_driver_factory).to receive(:create_rpc_driver).and_raise(SocketError)

    c = PostalMethods::Client.new(PM_OPTS)
    VCR.use_cassette('client/invalid_endpoint/prepare') do
      lambda {c.prepare!}.should raise_error(PostalMethods::NoConnectionError)
    end
  end

  it "should be able to set a work mode" do
    c = PostalMethods::Client.new(PM_OPTS)
    c.work_mode.should == "Default"
    c.work_mode = "ProdUCTion"
    c.work_mode.should == "Production"
    c.work_mode.should be_a_kind_of(String)
  end
end

require File.dirname(__FILE__) + '/spec_helper.rb'

describe "Document Processing" do
  let(:client) { PostalMethods::Client.new(PM_OPTS) }

  it "should open a valid pre-opened document" do
    client.document = open(File.dirname(__FILE__) + '/../spec/doc/sample.pdf')
    client.document.class.should == Hash
  end

  it "should open a valid document path" do
    client.document = File.dirname(__FILE__) + '/../spec/doc/sample.pdf'
    client.document.class.should == Hash
  end

  it "should create a hash with the right elements" do
    client.document = File.dirname(__FILE__) + '/../spec/doc/sample.pdf'
    client.document[:extension].should == "pdf"
    client.document[:bytes].length.should == 213312
    client.document[:name].should == "sample.pdf"
    client.document[:file_obj].class.should == File
  end

  it "should return true on a valid document path" do
    client.document = File.dirname(__FILE__) + '/../spec/doc/sample.pdf'
    client.document?.should == true
  end

  it "should throw an exception on a false path" do
    doc = File.dirname(__FILE__) + '/../spec/doc/does_not_exist.pdf'
    lambda { client.document = doc }.should raise_error(Errno::ENOENT)
  end
end

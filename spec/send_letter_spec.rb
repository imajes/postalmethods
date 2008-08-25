require File.dirname(__FILE__) + '/spec_helper.rb'

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
    lambda {@client.send_letter(@doc, "the long goodbye")}.should raise_error(PostalMethods::NoPreparationException)
  end  
  
  it "should raise proper exception when trying to send textfile" do
    @doc = open(File.dirname(__FILE__) + '/../README.txt')
    @client.prepare!
    lambda {@client.send_letter(@doc, "the long goodbye")}.should raise_error(PostalMethods::APIStatusCode3004Exception)
  end
  
end

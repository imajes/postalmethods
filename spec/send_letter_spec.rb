require File.dirname(__FILE__) + '/spec_helper.rb'

describe "Send Letter" do
  
  before :each do
    @doc = open(File.dirname(__FILE__) + '/../doc/sample.pdf')
    @client = PostalMethods::Client.new(PM_OPTS)
  end
  
  it "should instantiate and send a letter" do
    @client.prepare!
    rv = @client.send_letter(@doc, "the long goodbye")
  end
  
  it "should refuse to send letter before prepare" do
    lambda {@client.send_letter(@doc, "the long goodbye")}.should raise_error(PostalMethods::NoPreparationException)
  end  
  
  it "should raise the proper exception when trying to send textfile" do
    @doc = open(File.dirname(__FILE__) + '/../README.txt')
    @client.prepare!
    lambda {@client.send_letter(@doc, "the long goodbye")}.should raise_error(PostalMethods::APIStatusCode3004Exception)
  end
  
  it "should raise the proper exception when trying to send an empty string" do
    @client.prepare!
    lambda {@client.send_letter("", "the long goodbye")}.should raise_error(Errno::ENOENT)
  end
  
  #it "should raise the proper exception when trying to send no description" do
  #  @client.prepare!
  #  lambda {@client.send_letter(@doc, nil)}.should raise_error(PostalMethods::APIStatusCode3004Exception)
  #end
  
end

describe "Send Letter With Address" do
  
  before :each do
    @doc = open(File.dirname(__FILE__) + '/../doc/sample.pdf')
    @addr = {:AttentionLine1 => "The Fonz", :Address1 => "Happy Days", :City => "Baja", :State => "CA", 
             :PostalCode => "90210", :Country => "USA"}
    @client = PostalMethods::Client.new(PM_OPTS)
  end
  
  it "should instantiate and send a letter with address" do
    @client.prepare!
    rv = @client.send_letter_and_address(@doc, "Shark Jumping Notes", @addr)
    puts rv
    puts rv.inspect
  end
  
  it "should raise the proper exception when trying to send letter without valid attention line" do
    @client.prepare!
    addr = @addr.except(:AttentionLine1)
    lambda {@client.send_letter_and_address(@doc, "the long goodbye", addr)}.should raise_error(PostalMethods::APIStatusCode4008Exception)
  end
  
end

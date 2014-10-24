require File.dirname(__FILE__) + '/spec_helper.rb'
require 'base64'

describe "Utility Methods" do
  let(:doc) { open(File.dirname(__FILE__) + '/../spec/doc/sample.pdf') }
  let(:client) { PostalMethods::Client.new(PM_OPTS) }

  it "should check for error for when there is no file yet" do
    VCR.use_cassette "get_pdf_too_early/prepare" do
      client.prepare!
    end

    id = nil
    VCR.use_cassette "get_pdf_too_early/send_letter" do
      id = client.send_letter(doc, "the long goodbye")
    end

    VCR.use_cassette "get_pdf_too_early/get_pdf" do
      lambda { client.get_pdf(id) }.should raise_error(PostalMethods::APIStatusCode3020Exception)
    end
  end

  it "should raise a letter does not exist (3116) error when trying to get details of an invalid letter" do
    VCR.use_cassette "get_letter_details_invalid/prepare" do
      client.prepare!
    end

    VCR.use_cassette "get_letter_details_invalid/get_letter_details" do
      #sleep(6) # got to wait 6 seconds...
      lambda { client.get_letter_details(1) }.should raise_error(PostalMethods::APIStatusCode3116Exception)
    end
  end

  it "should raise a letter does not exist (3116) error when trying to cancel an invalid letter" do
    VCR.use_cassette "cancel_delivery_invalid/prepare" do
      client.prepare!
    end

    VCR.use_cassette "cancel_delivery_invalid/cancel_delivery_invalid" do
      lambda { client.cancel_delivery(1) }.should raise_error(PostalMethods::APIStatusCode3116Exception)
    end
  end

  context "When letter has been sent" do
    before do
      VCR.use_cassette "when_letter_has_been_sent/prepare" do
        client.prepare!
      end

      VCR.use_cassette "when_letter_has_been_sent/send_letter" do
        @id = client.send_letter(doc, "the long goodbye")
      end
    end

    xit "Should get a pdf returned for a file sent" do
      sleep 20
      VCR.use_cassette "when_letter_has_been_sent/get_pdf" do
        rv = client.get_pdf(@id)

        # TODO - just read the header instead of writing this to disk
        f = open("test_output.pdf", "w")

        f.write(rv)
        (`file test_output.pdf`).should == "test_output.pdf: PDF document, version 1.4\n"
        system("rm test_output.pdf")
      end
    end

    it "should get the details of a letter" do
      VCR.use_cassette "when_letter_has_been_sent/get_letter_details" do
        #sleep(10) # because it's a tired little clients
        details = client.get_letter_details(@id)

        # check the return...
        details.should be_an_instance_of(Array)

        # and now the item...
        details.first.should be_an_instance_of(SOAP::Mapping::Object)

        details.first.price.should == "0.00"
        details.first.iD.to_i.should == @id ## be careful not to confuse with class id
        details.last.should be_a_kind_of(String)
        details.last.should == "Development"
      end
    end

    it "should cancel delivery of a letter" do
      VCR.use_cassette "when_letter_has_been_sent/cancel_delivery" do
        rv = client.cancel_delivery(@id)
        rv.should == true
      end
    end
  end
end

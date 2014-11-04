require File.dirname(__FILE__) + '/spec_helper.rb'

describe "PostalMethods" do
  let(:pdf)    { open(File.dirname(__FILE__) + '/../spec/doc/sample.pdf') }
  let(:txt)    { open(File.dirname(__FILE__) + '/../README.md') }
  let(:client) { PostalMethods::Client.new(PM_OPTS) }

  describe "Send Letter" do

    it "should refuse to send letter before prepare" do
      lambda { client.send_letter(pdf, "the long goodbye") }.should raise_error(PostalMethods::NoPreparationException)
    end

    context "with prepare" do

      before do
        VCR.use_cassette('send_letter/prepare') do
          client.prepare!
        end
      end

      it "should instantiate and send a letter" do
        VCR.use_cassette('send_letter/send_letter') do
          client.send_letter(pdf, "the long goodbye").should > 0
        end
      end

      it "should raise the proper exception when trying to send text file" do
        VCR.use_cassette('send_letter/send_letter_with_text_file') do
          lambda { client.send_letter(txt, "the long goodbye")}.should raise_error(PostalMethods::APIStatusCode3004Exception)
        end
      end

      it "should raise the proper exception when trying to send an empty string" do
        VCR.use_cassette('send_letter/send_letter_with_empty_string') do
          lambda { client.send_letter("", "the long goodbye") }.should raise_error(Errno::ENOENT)
        end
      end
    end
  end

  describe "Send Letter With Address" do

    let(:addr) do
      {
        :AttentionLine1 => "George Washington", :Address1 => "The White House",
        :Address2 => "1600 Pennsylvania Ave", :City => "Washington",
        :State => "DC", :PostalCode => "20500", :Country => "USA"
      }
    end

    it "should refuse to send letter before prepare" do
      VCR.use_cassette('send_letter_with_address/send_letter_with_address_and_without_prepare') do
        lambda { client.send_letter_with_address(pdf, "the long goodbye", addr) }.should raise_error(PostalMethods::NoPreparationException)
      end
    end

    context "with prepare" do

      before do
        VCR.use_cassette('send_letter_with_address/prepare') do
          client.prepare!
        end
      end

      it "should instantiate and send a letter with address" do
        VCR.use_cassette('send_letter_with_address/send_letter_with_address') do
          client.send_letter_with_address(pdf, "Shark Jumping Notes", addr).should > 0
        end
      end

      it "should raise the proper exception when trying to send letter without valid attention line" do
        VCR.use_cassette('send_letter_with_address/send_letter_with_address_and_without_attention') do
          address_without_attention = addr.except(:AttentionLine1)
          lambda { client.send_letter_with_address(pdf, "the long goodbye", address_without_attention) }.should raise_error(PostalMethods::APIStatusCode4008Exception)
        end
      end

      it "should raise the proper exception when trying to send textfile" do
        VCR.use_cassette('send_letter_with_address/send_letter_with_address_and_with_textfile') do
          lambda { client.send_letter_with_address(txt, "the long goodbye", addr) }.should raise_error(PostalMethods::APIStatusCode3004Exception)
        end
      end

      it "should raise the proper exception when trying to send an empty string" do
        VCR.use_cassette('send_letter_with_address/send_letter_with_address_and_with_empty_string') do
          lambda { client.send_letter_with_address("", "the long goodbye", addr) }.should raise_error(Errno::ENOENT)
        end
      end
    end
  end
end

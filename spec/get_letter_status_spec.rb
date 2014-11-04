require File.dirname(__FILE__) + '/spec_helper.rb'

describe "Get Letter Status" do

  before :each do
    @doc = open(File.dirname(__FILE__) + '/../spec/doc/sample.pdf')
    @client = PostalMethods::Client.new(PM_OPTS)

    VCR.use_cassette('get_letter_status/prepare') do
      @client.prepare!
    end
    #sleep(10)
  end

  it "should send a letter and get status" do
    ## use a static known good id that has gone thru in dev mode
    rv = nil
    VCR.use_cassette('get_letter_status/send_letter') do
      rv = @client.send_letter(@doc, "the long goodbye")
    end
    VCR.use_cassette('get_letter_status/get_letter_status') do
      f = @client.get_letter_status(rv)
      f.length.should == 2
      # Currently returns:
      # -910 In Process. Letter is being processed. Processing may take a few hours.
      #f.first.to_i.should == -1002
    end
  end

  xit "should try to get status of a letter i don't have access to" do
    VCR.use_cassette('get_letter_status/get_letter_status_raise_3116_exception') do
      # FIXME: this is a bad test as it doesn't really prove what we're trying to.
      # much better to have a different user make a new post etc..
      lambda { @client.get_letter_status(1999999) }.should raise_error(PostalMethods::APIStatusCode3116Exception)
    end
  end

  it "should send multiple letters and get their status" do
    letters = []
    1.upto(3) do |i|
      VCR.use_cassette("get_letter_status/#{i}/prepare") do
        @doc = open(File.dirname(__FILE__) + '/../spec/doc/sample.pdf')
        @client = PostalMethods::Client.new(PM_OPTS)
        @client.prepare!
      end
      VCR.use_cassette("get_letter_status/#{i}/send_letter") do
        rv = @client.send_letter(@doc, "the long goodbye")
        rv.should > 0
        letters << rv
        #sleep(10) # api needs some time
      end
    end

    VCR.use_cassette('get_letter_status/get_letter_status_multiple') do
      ret = @client.get_letter_status_multiple(letters)
      ret.should be_an_instance_of(Array)

      # the return is an array [results, status]
      recv_letters = ret.collect { |r| r.iD.to_i }

      recv_letters.should == letters
    end
  end

  it "should attempt to request a multiple array of invalid letters" do
    VCR.use_cassette('get_letter_status/get_letter_status_multiple_raise_3115_exception') do
      lambda { @client.get_letter_status_multiple([1,2,3]) }.should raise_error(PostalMethods::APIStatusCode3115Exception)
    end
  end

  it "should request a range of letters and get their status" do
    letters = []
    1.upto(3) do |i|
      VCR.use_cassette("get_letter_status/get_letter_status_range/#{i}/prepare") do
        @doc = open(File.dirname(__FILE__) + '/../spec/doc/sample.pdf')
        @client = PostalMethods::Client.new(PM_OPTS)
        @client.prepare!
      end
      VCR.use_cassette("get_letter_status/get_letter_status_range/#{i}/send_letter") do
        rv = @client.send_letter(@doc, "the long goodbye")
        rv.should > 0
        letters << rv
        #sleep(10) # api needs some time
      end
    end

    VCR.use_cassette('get_letter_status/get_letter_status_range') do
      ret = @client.get_letter_status_range(letters.first, letters.last)
      ret.should be_an_instance_of(Array)

      # the return is an array [results, status]
      recv_letters = ret.collect { |r| r.iD.to_i }

      recv_letters.should == letters
    end
  end

  xit "should attempt to request a range of invalid letters" do
    VCR.use_cassette('get_letter_status/get_letter_status_range_raise_3115_exception') do
      lambda { @client.get_letter_status_range(1001,1003) }.should raise_error(PostalMethods::APIStatusCode3115Exception)
    end
  end
end

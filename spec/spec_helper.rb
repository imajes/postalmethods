$:.unshift(File.dirname(__FILE__) + '/../lib')
require 'postalmethods'
require 'rspec'
require 'vcr'
require 'webmock'

RSpec.configure do |config|
  config.order = 'random'
end

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
end

$VERBOSE = nil ##silence annoying warnings from soap4r

PM_OPTS = {
  :username => ENV['POSTAL_METHODS_USERNAME'],
  :password => ENV['POSTAL_METHODS_PASSWORD'],
  :api_key  => ENV['POSTAL_METHODS_API_KEY']
}

# hash hacks to make hacking in specs easier
class Hash
  # for excluding keys
  def except(*exclusions)
    self.reject { |key, value| exclusions.include? key.to_sym }
  end

  # for overriding keys
  def with(overrides = {})
    self.merge overrides
  end
end

#require "ruby-debug"

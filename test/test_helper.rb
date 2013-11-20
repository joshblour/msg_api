# Configure Rails Environment
ENV["RAILS_ENV"] = "test"
ENV['MSG_API_URL'] = 'http://test.com'

require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require "rails/test_help"
require 'webmock/test_unit'

include WebMock::API

Rails.backtrace_cleaner.remove_silencers!

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

# Load fixtures from the engine
if ActiveSupport::TestCase.method_defined?(:fixture_path=)
  ActiveSupport::TestCase.fixture_path = File.expand_path("../fixtures", __FILE__)
end
# 
# WebMock.after_request do |request_signature, response|
#   puts "Request #{request_signature} was made and #{response.inspect} was returned"
# end
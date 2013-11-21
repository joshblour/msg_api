require 'test_helper'

class MyMiddlewareTest < ActiveSupport::TestCase

  test 'injects token from request store into authorization hash before request' do
    stub_get = stub_request(:get, "http://test.com")
    RequestStore.store[:token] = 'foobar_token'
    
    $api.get
    assert_requested :get, "http://test.com", :headers => {'Authorization' => "Token token=\"foobar_token\""}
  end

end

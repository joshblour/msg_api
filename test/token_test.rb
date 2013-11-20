require 'api/token'
require 'test_helper'

class TokenTest < ActiveSupport::TestCase
  setup do
    @user = User.create
  end
  
  test "returns a token for a user" do
    token = Token.generate_token_for(@user)
    assert_not_nil token
    assert_not_nil Base64.urlsafe_decode64(token)
  end
end

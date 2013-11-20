require 'api/encryptor'
require 'test_helper'

class EncryptorTest < ActiveSupport::TestCase
  setup do
    @user = User.create
  end
  
  test "encrypts string" do
    # generate @public_key then call .public_key and MsgApiecrypt with it. then try to decrypt directrly
    token = MsgApi::Encryptor.encrypt('foobar')
    assert_not_nil Base64.urlsafe_decode64(token)
  end
end

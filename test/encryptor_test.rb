require 'api/encryptor'
require 'test_helper'

class EncryptorTest < ActiveSupport::TestCase
  setup do
    @user = User.create
  end
  
  test "encrypts string" do
    private_key = OpenSSL::PKey::RSA.generate 1024
    token = MsgApi::Encryptor.encrypt('foobar', private_key)    
    assert_equal 'foobar', private_key.private_decrypt(Base64.urlsafe_decode64(token))
  end
  
  test "uses public key file if key is not provided" do
    token = MsgApi::Encryptor.encrypt('foobar')    
    assert_not_nil Base64.urlsafe_decode64(token)
  end
  
  test 'returns public key object' do
    assert_kind_of OpenSSL::PKey::RSA, MsgApi::Encryptor.send(:public_key)
  end
end

require 'openssl'
require 'base64'

module MsgApi
  module Encryptor
  
    def self.encrypt(string)
      Base64.urlsafe_encode64(public_key.public_encrypt(string))
    end
  
    private
  
    def self.root
      File.expand_path '../../..', __FILE__
    end
  
    def self.public_key
      @public_key ||= OpenSSL::PKey::RSA.new(File.read(File.join(root, 'public_key.pub')))
    end
    
  end
end
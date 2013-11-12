require 'api/encryptor'

module Token
  class << self
    
    def generate_token_for(member)
      #TODO: figure out how to set this token from the host application
      token = "4c6075460341d7d2a6eacc24fc88b707"
      json = {token: token, member_type: member.class.to_s, member_id: member.id, time: Time.now}.to_json
      return MsgApi::Encryptor.encrypt(json)
    end
    
  end
  
end
require 'api/encryptor'

module Token
  class << self
    
    def generate_token_for(member)
      #TODO: figure out how to set this token from the host application
      token = "4c6075460341d7d"
      json = {token: token, type: member.class.to_s, id: member.id, time: Time.now.to_i}.to_json
      return MsgApi::Encryptor.encrypt(json)
    end
    
  end
  
end
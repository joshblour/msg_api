require 'api/encryptor'

module Token
  class << self
    
    def generate_token_for(member)
      #TODO: figure out how to set this token from the host application
      
      token = MsgApi::TOKEN #|| "489f5bd2c34d47e1"
      json = {token: token, type: member.class.to_s, id: member.id, time: Time.now.to_i}.to_json
      return MsgApi::Encryptor.encrypt(json)
    end
    
  end
  
end
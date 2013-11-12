module MsgApi
  class MemberMap
    include Her::Model
    
    belongs_to :conversation
    
    include_root_in_json :message_attributes
    # parse_root_in_json true, format: :active_model_serializers
    

  end
end
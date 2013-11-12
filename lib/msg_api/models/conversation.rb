module MsgApi
  class Conversation
    include Her::Model

    has_many :messages
    # has_many :member_maps
    # 
    include_root_in_json true
    request_new_object_on_build true
    
    parse_root_in_json true, format: :active_model_serializers
    
    accepts_nested_attributes_for :messages
    
  end
end
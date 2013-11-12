module MsgApi
  class Message
    include Her::Model
    
    # belongs_to :conversation
    # resource_path "conversations/:conversation_id/messages/:id"
    # collection_path "conversations/:conversation_id/messages"
    request_new_object_on_build true
    
    
    include_root_in_json true
    # parse_root_in_json true, format: :active_model_serializers
    
  end
end
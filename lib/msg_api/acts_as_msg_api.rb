require 'api/token'

module MsgApi
  module ActsAsMsgApi
    extend ActiveSupport::Concern

    included do
    end

    module ClassMethods
      def acts_as_msg_api(options = {})
        # TODO: figure out how to allow users to specify the 'conversations' method name
        include MsgApi::ActsAsMsgApi::LocalInstanceMethods
      end
    end
    
    module LocalInstanceMethods
  

      def conversations(classes = [] )
        #generate encrypted token for the current user
        RequestStore.store[:token] = Token.generate_token_for(self)
        if classes.empty?
          $api.get('conversations')['conversations']
        else
          $api.get('conversations', includes: [classes].flatten)['conversations']        
        end
      end
      
      def start_conversation(recipients, title, body = nil )
        RequestStore.store[:token] = Token.generate_token_for(self)
        member_maps = [recipients].flatten.map {|r| {member_type: r.class.to_s, member_id: r.id} }
        params = {title: title, member_maps_attributes: member_maps}
        params[:messages_attributes] = [{body: body}] if body
        $api.post('conversations', conversation: params)
      end
      
      def get_conversation(conversation_id)
        RequestStore.store[:token] = Token.generate_token_for(self)
        $api.get("conversations/#{conversation_id}")['conversation']     
      end
      
      def send_message(conversation_id, body)
        RequestStore.store[:token] = Token.generate_token_for(self)
        params = {body: body}
        $api.post("conversations/#{conversation_id}/messages", message: params)        
      end
      
      def leave_conversation(conversation_id)
        RequestStore.store[:token] = Token.generate_token_for(self)
        $api.delete("conversations/#{conversation_id}")        
      end
      
      
    end
  end
end

ActiveRecord::Base.send :include, MsgApi::ActsAsMsgApi
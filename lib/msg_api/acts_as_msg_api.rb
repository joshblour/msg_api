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
      def conversations
        #generate encrypted token for the current user
        RequestStore.store[:token] = Token.generate_token_for(self)
        MsgApi::Conversation
      end
      
      # def start_conversation(recipients, title, body )
      #     RequestStore.store[:token] = Token.generate_token_for(self)
      #     member_maps = [recipients].flatten.map {|r| {member_type: r.class.to_s, member_id: r.id} }
      #     params = {title: title, member_maps_attributes: member_maps, messages_attributes: [{body: body}]}
      #     $api.post('conversations', conversation: params)
      #     # Conversation.create(title: title, member_maps_attributes: member_maps, messages_attributes: [{body: body}])
      #   end
      
    end
  end
end

ActiveRecord::Base.send :include, MsgApi::ActsAsMsgApi
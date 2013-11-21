require 'test_helper'


class ActsAsMsgApiTest < ActiveSupport::TestCase
  
  setup do
    @user = User.create
    RequestStore.store[:token] = nil
    WebMock.reset!
  end


  test 'adds a acts_as_msg_api method to class' do
    assert User.respond_to?(:acts_as_msg_api)
  end 
  
  ###conversations METHOD    
  test 'adds a conversations method to the user object' do
    assert @user.respond_to?(:conversations)
  end

  test 'makes request for conversations' do
    stub_get = stub_request(:get, "http://test.com/conversations").to_return(body: {})
    @user.conversations
    assert_requested(stub_get)    
  end
  
  test 'returns content of conversations hash' do
    stub_get = stub_request(:get, "http://test.com/conversations").to_return(body: {'conversations' => 'foobar'})
    assert_equal 'foobar', @user.conversations
  end
  
  test 'sets request store token in conversations method' do
    stub_get = stub_request(:get, "http://test.com/conversations").to_return(body: {})

    @user.conversations
    assert_not_nil RequestStore.store[:token]
  end

  ####start_conversation METHOD
  test 'adds a start_conversation method to the user object' do
    assert @user.respond_to?(:start_conversation)
  end
  
  test 'sets request store token in start_conversation method' do
    stub_post = stub_request(:post, "http://test.com/conversations")
    
    @user.start_conversation(@user, 'hello')
    assert_not_nil RequestStore.store[:token]
  end
  
  test 'makes a post request to api' do
    stub_post = stub_request(:post, "http://test.com/conversations")
    
    @user.start_conversation(@user, 'hello')
    assert_requested(stub_post)    
  end
  
  test 'includes a member map for recipient' do
    stub_get = stub_request(:post, "http://test.com/conversations")
    
    @user.start_conversation(@user, 'hello')
    assert_requested :post,  "http://test.com/conversations", body: {conversation: {title: 'hello', member_maps_attributes: [{member_type: 'User', member_id: @user.id}]}}
  end
  
  test 'optionally includes a body' do
    stub_get = stub_request(:post, "http://test.com/conversations")
    
    @user.start_conversation(@user, 'hello', 'nice bod')
    assert_requested :post,  "http://test.com/conversations", body: {conversation: {title: 'hello', messages_attributes: [{body: 'nice bod'}],member_maps_attributes: [{member_type: 'User', member_id: @user.id}]}}
  end
  
  test 'accepts mutliple recipients' do
    @other_user = User.create
    stub_get = stub_request(:post, "http://test.com/conversations")
    
    @user.start_conversation([@user, @other_user], 'hello')
    assert_requested :post,  "http://test.com/conversations", body: {conversation: {title: 'hello', member_maps_attributes: [{member_type: 'User', member_id: @user.id}, {member_type: 'User', member_id: @other_user.id}]}}    
  end
  
  ###get_conversation METHOD
  
  test 'adds a get_conversation method to user' do
    assert @user.respond_to?(:get_conversation)
  end
  
  test 'sets request store token for get_conversation method' do
    stub_get = stub_request(:get, "http://test.com/conversations/1").to_return(body: {'conversation' => 'foobar'})
    
    @user.get_conversation(1)
    assert_not_nil RequestStore.store[:token]
  end
  
  test 'makes a get request with conversation id' do
    stub_get = stub_request(:get, "http://test.com/conversations/1").to_return(body: {'conversation' => 'foobar'})
    
    @user.get_conversation(1)
    assert_requested(stub_get)    
  end
  
  test 'returns contents of conversation hash' do
    stub_get = stub_request(:get, "http://test.com/conversations/1").to_return(body: {'conversation' => 'foobar'})
    
    assert_equal 'foobar', @user.get_conversation(1)
  end


  ###send_message METHOD
  
  test 'adds a send_message method to user' do
    assert @user.respond_to?(:send_message)
  end
  
  test 'sets request store for send_message method' do
    stub_post = stub_request(:post, "http://test.com/conversations/1/messages")
    
    @user.send_message(1, 'hello')
    assert_not_nil RequestStore.store[:token]
  end
  
  test 'makes a post request to a specific conversation with message body' do
    stub_post = stub_request(:post, "http://test.com/conversations/1/messages").with(messages: {body: 'hello'})
    
    @user.send_message(1, 'hello')
    assert_requested(stub_post)    
  end
  
  ###leave_conversation METHOD
  test 'adds a leave_conversation to user' do
    assert @user.respond_to?(:leave_conversation)
  end
  
  test 'sets request store for leave_conversation method' do
    stub_post = stub_request(:delete, "http://test.com/conversations/1")
    
    @user.leave_conversation(1)
    assert_not_nil RequestStore.store[:token]
  end
  
  test 'makes a delete request to a specific conversation' do
    stub_delete = stub_request(:delete, "http://test.com/conversations/1")
    
    @user.leave_conversation(1)
    assert_requested(stub_delete)
  end

end
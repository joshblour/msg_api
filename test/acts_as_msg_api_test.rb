require 'test_helper'


class ActsAsMsgApiTest < ActiveSupport::TestCase
  
  setup do
    @user = User.create
  end

  test 'adds a acts_as_msg_api method to class' do
    assert User.respond_to?(:acts_as_msg_api)
  end 
  
  test 'adds a conversations method to the user object' do
    assert @user.respond_to?(:conversations)
  end
  
  test 'makes request for conversations' do
    stub_get = stub_request(:get, "http://test.com/conversations").to_return(body: {})
    @user.conversations
    assert_requested(stub_get)    
  end
  
  # test 'returns content of conversations ' do
  #   stub_get = stub_request(:get, "http://test.com/conversations").to_return(body: {conversations: ['foobar']}.to_json)
  #   
  #   assert_equal 'foobar', @user.conversations
  #   assert_requested(stub_get)    
  # end
  

end
require 'test_helper'

class ActsAsMsgApiTest < ActiveSupport::TestCase

  test 'adds a acts_as_msg_api method to class' do
    assert User.respond_to?(:acts_as_msg_api)
  end 
  
  test 'adds a conversations method to the user object' do
    assert User.new.respond_to?(:conversations)
  end
end
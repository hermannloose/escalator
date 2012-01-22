require 'test_helper'

class GoogleClientLoginControllerTest < ActionController::TestCase
  test "should raise ArgumentError for missing :email parameter" do
    assert_raise ArgumentError do
      post :create, :email => nil, :password => "present"
    end
  end

  test "should raise ArgumentError for missing :password parameter" do
    assert_raise ArgumentError do
      post :create, :email => "present", :password => nil
    end
  end
end

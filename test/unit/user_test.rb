require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "should validate presence of name" do
    user = User.new
    user.email = "present"
    assert !user.save
  end

  test "should validate presence of email" do
    user = User.new
    user.name = "present"
    assert !user.save
  end
end

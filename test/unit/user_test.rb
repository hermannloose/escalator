require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @user = users(:valid)
  end

  test "should save valid user" do
    assert @user.save
  end

  test "should validate presence of name" do
    @user.name = nil
    assert !@user.save
  end

  test "should validate presence of email" do
    @user.email = nil
    assert !@user.save
  end
end

require 'test_helper'

class RotationTest < ActiveSupport::TestCase
  setup do
    @rotation = rotations(:valid)
  end

  test "should save valid rotation" do
    assert @rotation.save
  end

  test "should validate presence of name" do
    @rotation.name = nil
    assert !@rotation.save
  end

  test "should order users by rank" do
    user1 = users(:one)
    user2 = users(:two)
    user3 = users(:three)
    rotation1 = rotations(:one)
    rotation2 = rotations(:two)

    assert_equal [user1, user2], rotation1.users
    assert_equal [user2, user3], rotation2.users
  end
end

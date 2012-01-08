require 'test_helper'

class RotationMembershipTest < ActiveSupport::TestCase
  setup do
    @membership = rotation_memberships(:valid)
  end

  test "should save valid rotation membership" do
    assert @membership.save
  end

  test "should validate presence of rotation" do
    @membership.rotation = nil
    assert !@membership.save
  end

  test "should validate presence of user" do
    @membership.user = nil
    assert !@membership.save
  end
end

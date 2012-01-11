require 'test_helper'

class EscalationPolicyTest < ActiveSupport::TestCase
  setup do
    @policy = escalation_policies(:valid)
  end

  test "should save valid escalation policy" do
    assert @policy.save
  end

  test "should validate presence of name" do
    @policy.name = nil
    assert !@policy.save
  end

  test "should get current on-call user" do
    issue1 = issues("1-1")
    issue2 = issues("1-2")
    assert_equal users(:one), escalation_policies(:one).oncall(issue1)
    assert_equal users(:two), escalation_policies(:one).oncall(issue2)
  end
end

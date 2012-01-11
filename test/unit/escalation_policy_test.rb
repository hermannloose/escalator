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
    assert escalation_policies(:one).oncall == users(:one)
  end
end

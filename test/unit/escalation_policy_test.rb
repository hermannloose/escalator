require 'test_helper'

class EscalationPolicyTest < ActiveSupport::TestCase
  test "should validate presence of name" do
    policy = EscalationPolicy.new
    assert !policy.save
  end
end

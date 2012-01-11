require 'test_helper'

class EscalationStepTest < ActiveSupport::TestCase
  setup do
    @step = escalation_steps(:valid)
  end

  test "should save valid escalation step" do
    assert @step.save
  end

  test "should allow a delay of zero" do
    @step.delay = 0
    assert @step.save
  end

  test "should not allow negative delays" do
    @step.delay = -1
    assert !@step.save
  end

  test "should only allow integer delays" do
    @step.delay = 1.1
    assert !@step.save
  end

  test "should validate presence of escalation_policy" do
    @step.escalation_policy = nil
    assert !@step.save
  end

  test "should validate presence of rotation" do
    @step.rotation = nil
    assert !@step.save
  end
end

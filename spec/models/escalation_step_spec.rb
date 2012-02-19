require 'spec_helper'

describe EscalationStep do
  it { should belong_to :escalation_policy }
  it { should belong_to :rotation }

  it { should validate_numericality_of :delay_minutes }
  it { should_not allow_value(-1).for(:delay_minutes) }
  it { should_not allow_value(1.1).for(:delay_minutes) }
  it { should validate_presence_of :escalation_policy_id }
  it { should validate_presence_of :rotation_id }

  it "should have an 'ordered' scope" do
    EscalationStep.should respond_to :ordered
  end
end

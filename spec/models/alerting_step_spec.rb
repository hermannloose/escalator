require 'spec_helper'

describe AlertingStep do
  it { should belong_to :contact_detail }
  it { should belong_to :rotation_membership }

  it { should validate_numericality_of :delay_minutes }
  it { should_not allow_value(-1).for(:delay_minutes) }
  it { should_not allow_value(1.1).for(:delay_minutes) }
  it { should validate_presence_of :contact_detail_id }
  it { should validate_presence_of :rotation_membership_id }

  it "should have an 'ordered' scope" do
    AlertingStep.should respond_to :ordered
  end
end

require 'spec_helper'

describe RotationMembership do
  it { should belong_to :user }
  it { should belong_to :rotation }
  it { should have_many :alerting_steps }

  it { should validate_numericality_of :rank }
  it { should_not allow_value(-1).for(:rank) }
  it { should_not allow_value(1.1).for(:rank) }
  it { should validate_presence_of :user_id }
  it { should validate_presence_of :rotation_id }

  it "should have an 'ordered' scope" do
    RotationMembership.should respond_to :ordered
  end
end

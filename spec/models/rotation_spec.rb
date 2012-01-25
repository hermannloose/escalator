require 'spec_helper'

describe Rotation do
  it { should have_many :rotation_memberships }
  it { should have_many(:users).through(:rotation_memberships) }
  it "should have a handle to the currently pending RotationJob" do
    should belong_to(:delayed_job)
  end

  it { should validate_presence_of :name }
  it { should validate_numericality_of :rotate_every }
  it { should_not allow_value(-1).for(:rotate_every) }
  it { should_not allow_value(0).for(:rotate_every) }
  it { should_not allow_value(1.1).for(:rotate_every) }
  it { should_not allow_value(899).for(:rotate_every) }
  it { should allow_value(900).for(:rotate_every) }
end

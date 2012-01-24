require 'spec_helper'

describe Rotation do
  it { should have_many :rotation_memberships }
  it { should have_many(:users).through(:rotation_memberships) }

  it { should validate_presence_of :name }
end

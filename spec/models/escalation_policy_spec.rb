require 'spec_helper'

describe EscalationPolicy do
  it { should have_many :escalation_steps }
  it { should have_many :issues }

  it { should validate_presence_of :name }
end

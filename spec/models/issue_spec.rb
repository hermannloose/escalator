require 'spec_helper'

describe Issue do
  fixtures :issues

  subject { issues(:valid) }

  it { should belong_to :escalation_policy }

  it { should validate_presence_of :escalation_policy_id }
  it { should validate_presence_of :title }
  it { should validate_presence_of :status }

  it { should respond_to :description }
  it { should respond_to :posted_at }
end

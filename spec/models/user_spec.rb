require 'spec_helper'

describe User do
  it { should have_many :assignments }
  it { should have_many(:roles).through(:assignments) }
  it { should have_many :contact_details }
  it { should have_many :issues }
  it { should have_many :rotation_memberships }
  it { should have_many(:rotations).through(:rotation_memberships) }

  it { should validate_presence_of :name }
  it { should validate_presence_of :email }

  context "to be used with declarative_authorization" do
    it { should respond_to :role_symbols }
  end
end

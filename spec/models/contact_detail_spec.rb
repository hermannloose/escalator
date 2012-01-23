require 'spec_helper'

describe ContactDetail do
  it { should belong_to :user }
  it { should have_many :contact_detail_properties }

  it { should validate_presence_of :name }
  it { should validate_presence_of :user_id }
end

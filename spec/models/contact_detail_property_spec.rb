require 'spec_helper'

describe ContactDetailProperty do
  it { should belong_to :contact_detail }

  it { should validate_presence_of :contact_detail_id }
  it { should validate_presence_of :key }

  it { should respond_to :value }
end

require 'spec_helper'

describe GoogleClientLoginCredentials do
  subject { FactoryGirl.create(:google_client_login_credentials) }

  it { should validate_presence_of :email }
  it { should validate_presence_of :token }
end

require 'spec_helper'

describe GoogleClientLoginCredentials do
  fixtures :google_client_login_credentials

  subject { google_client_login_credentials(:valid) }

  it { should validate_presence_of :email }
  it { should validate_presence_of :token }
end

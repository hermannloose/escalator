require 'test_helper'

class GoogleClientLoginCredentialsTest < ActiveSupport::TestCase
  setup do
    @credentials = google_client_login_credentials(:valid)
  end

  test "should save valid credentials" do
    assert @credentials.save
  end

  test "should validate presence of email" do
    @credentials.email = nil
    assert !@credentials.save
  end

  test "should validate presence of token" do
    @credentials.token = nil
    assert !@credentials.save
  end
end

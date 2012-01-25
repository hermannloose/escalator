module AuthorizationHelper
  def setup_mapping
    before :each do
      request.env["devise.mapping"] = Devise.mappings[:user]
    end
  end
end

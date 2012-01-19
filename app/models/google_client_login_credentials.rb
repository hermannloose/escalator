class GoogleClientLoginCredentials < ActiveRecord::Base
  validates :email, :presence => true
  validates :token, :presence => true
end

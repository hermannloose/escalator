class User < ActiveRecord::Base
  has_many :contact_details
end

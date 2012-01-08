class User < ActiveRecord::Base
  has_many :contact_details
  has_many :rotation_memberships
  has_many :rotations, :through => :rotation_memberships
end

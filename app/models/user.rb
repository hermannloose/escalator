class User < ActiveRecord::Base
  has_many :contact_details
  has_many :rotation_memberships
  has_many :rotations, :through => :rotation_memberships

  validates :name, :presence => true
  validates :email, :presence => true
  validates :is_admin, :inclusion => { :in => [true, false] }
end

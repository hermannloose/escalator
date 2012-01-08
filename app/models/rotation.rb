class Rotation < ActiveRecord::Base
  has_many :rotation_memberships
  has_many :users, :through => :rotation_memberships

  validates :name, :presence => true
end

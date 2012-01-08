class RotationMembership < ActiveRecord::Base
  belongs_to :rotation
  belongs_to :user

  validates :rotation_id, :presence => true
  validates :user_id, :presence => true
end

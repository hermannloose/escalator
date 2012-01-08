class RotationMembership < ActiveRecord::Base
  belongs_to :rotation
  belongs_to :user
  has_many :alerting_steps

  validates :rotation_id, :presence => true
  validates :user_id, :presence => true
end

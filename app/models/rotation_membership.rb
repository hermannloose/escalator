class RotationMembership < ActiveRecord::Base
  belongs_to :rotation
  belongs_to :user
end

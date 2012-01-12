class RotationMembership < ActiveRecord::Base
  belongs_to :rotation
  belongs_to :user
  has_many :alerting_steps

  validates :rank, :numericality => {
    :only_integer => true,
    :greater_than_or_equal_to => 0
  }
  validates :rotation_id, :presence => true
  validates :user_id, :presence => true

  scope :ordered, order("rank")
end

class EscalationStep < ActiveRecord::Base
  belongs_to :escalation_policy
  belongs_to :rotation

  validates :delay, :numericality => { :only_integer => true, :greater_than_or_equal_to => 0 }
  validates :escalation_policy_id, :presence => true
  validates :rotation_id, :presence => true
end

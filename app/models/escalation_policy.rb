class EscalationPolicy < ActiveRecord::Base
  has_many :escalation_steps
  has_many :issues

  validates :name, :presence => true
end

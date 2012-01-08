class EscalationPolicy < ActiveRecord::Base
  has_many :escalation_steps

  validates :name, :presence => true
end

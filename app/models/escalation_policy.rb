class EscalationPolicy < ActiveRecord::Base
  has_many :escalation_steps
  has_many :issues

  validates :name, :presence => true

  def oncall(issue)
    delay = (Time.now - issue.posted_at) / 60
    step = escalation_steps.ordered.find_all { |step|
      step.delay_minutes < delay
    }.last
    step.rotation.users.first
  end
end

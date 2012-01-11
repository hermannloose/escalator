class EscalationPolicy < ActiveRecord::Base
  has_many :escalation_steps
  has_many :issues

  validates :name, :presence => true

  def oncall
    step = escalation_steps.ordered.first
    # TODO(hermannloose): Should make sure there's always at least one step.
    unless step.nil?
      step.rotation.users.first
    end
  end
end

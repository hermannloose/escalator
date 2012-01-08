class EscalationPolicy < ActiveRecord::Base
  validates :name, :presence => true
end

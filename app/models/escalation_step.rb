class EscalationStep < ActiveRecord::Base
  belongs_to :rotation

  validates :delay, :numericality => { :only_integer => true, :greater_than_or_equal_to => 0 }
  validates :rotation_id, :presence => true
end

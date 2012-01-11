class AlertingStep < ActiveRecord::Base
  belongs_to :contact_detail
  belongs_to :rotation_membership

  validates :delay, :numericality => {
    :only_integer => true,
    :greater_than_or_equal_to => 0
  }
  validates :contact_detail_id, :presence => true
  validates :rotation_membership_id, :presence => true

  scope :ordered, order("delay")
end

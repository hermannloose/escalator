class AlertingStep < ActiveRecord::Base
  belongs_to :contact_detail
  belongs_to :rotation_membership

  validates :contact_detail_id, :presence => true
  validates :rotation_membership_id, :presence => true
end

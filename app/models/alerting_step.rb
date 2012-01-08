class AlertingStep < ActiveRecord::Base
  belongs_to :contact_detail
  belongs_to :rotation_membership
end

class ContactDetailProperty < ActiveRecord::Base
  belongs_to :contact_detail

  validates :contact_detail_id, :presence => true
  validates :key, :presence => true
end

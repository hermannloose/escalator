class ContactDetail < ActiveRecord::Base
  belongs_to :user
  has_many :contact_detail_properties

  validates :name, :presence => true
  validates :user_id, :presence => true
end

class ContactDetail < ActiveRecord::Base
  belongs_to :user
  has_many :contact_detail_properties, :dependent => :destroy
  serialize :details, Hash

  validates :name, :presence => true
  validates :user_id, :presence => true
end

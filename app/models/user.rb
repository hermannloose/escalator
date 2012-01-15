class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
      :trackable, :validatable

  has_many :contact_details
  has_many :issues, :foreign_key => "assignee_id"
  has_many :rotation_memberships
  has_many :rotations, :through => :rotation_memberships

  validates :name, :presence => true
  validates :email, :presence => true

  def role_symbols
    [:admin, :user]
  end
end

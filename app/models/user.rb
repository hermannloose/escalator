class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
      :trackable, :validatable

  has_many :assignments
  has_many :roles, :through => :assignments

  has_many :contact_details
  has_many :issues, :foreign_key => "assignee_id"
  has_many :rotation_memberships
  has_many :rotations, :through => :rotation_memberships

  validates :name, :presence => true
  validates :email, :presence => true

  def role_symbols
    roles.map { |role| role.name.parameterize.underscore.to_sym }
  end
end

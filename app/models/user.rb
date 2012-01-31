class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
      :token_authenticatable, :trackable, :validatable

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

  def as_json(options = {})
    options[:except] ||= [
      :authentication_token, :current_sign_in_at, :current_sign_in_ip,
      :last_sign_in_at, :last_sign_in_ip, :encrypted_password, :password_salt,
      :remember_created_at, :reset_password_sent_at, :reset_password_token,
      :sign_in_count
    ]
    super(options)
  end
end

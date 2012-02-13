FactoryGirl.define do
  # Roles
  factory :admin_role, :class => Role do
    name 'admin'
  end

  factory :user_role, :class => Role do
    name 'user'
  end

  # Users
  factory :admin, :class => User do
    name 'Admin'
    sequence :email do |n|
      "admin#{n}@example.com"
    end
    password 'password'
    roles [ Factory(:admin_role) ]
  end

  factory :user, :class => User do
    name 'User'
    sequence :email do |n|
      "user#{n}@example.com"
    end
    password 'password'
    roles [ Factory(:user_role) ]
  end

  # Assignments
  factory :assignment do
    user FactoryGirl.create(:user)
    role FactoryGirl.create(:user_role)
  end

  # Contact details
  factory :contact_detail do
    sequence :name do |n|
      "ContactDetail ##{n}"
    end
    category :email
    user Factory(:user)
    details Hash.new
  end

  # Rotations
  factory :rotation do
    sequence :name do |n|
      "Rotation ##{n}"
    end
    rotate_every 1000
  end

  # Rotation memberships
  factory :rotation_membership do
    rotation Factory(:rotation)
    user Factory(:user)
    rank 0
  end

  # Alerting steps
  factory :alerting_step do
    delay_minutes 0
    rotation_membership Factory(:rotation_membership)
    contact_detail Factory(:contact_detail)
  end

  # Escalation policies
  factory :escalation_policy do
    sequence :name do |n|
      "Escalation Policy ##{n}"
    end
  end

  # Escalation steps
  factory :escalation_step do
    delay_minutes 0
    escalation_policy FactoryGirl.create(:escalation_policy)
    rotation FactoryGirl.create(:rotation)
  end

  # Issues
  factory :issue do
    sequence :title do |n|
      "Issue ##{n}"
    end
    escalation_policy FactoryGirl.create(:escalation_policy)
    status :open
    posted_at Time.zone.now
  end
end

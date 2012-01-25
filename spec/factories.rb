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
end

authorization do
  role :admin do
    includes :user

    has_permission_on :authorization_rules, :to => :read

    has_permission_on [:assignments, :google_client_login],
      :to => [:index, :show]

    has_permission_on [
      :assignments, :contact_details, :escalation_policies,
      :google_client_login, :issues, :rotations, :users
    ], :to => [
      :new, :create, :edit, :update, :destroy
    ]
  end

  role :user do
    includes :guest

    has_permission_on [
      :contact_details, :escalation_policies, :issues, :rotations, :users
    ], :to => [
      :index, :show
    ]
    has_permission_on :issues, :to => [:new, :create]
    has_permission_on :contact_details, :to => [
      :new, :create, :edit, :update, :destroy
    ] do
      if_attribute :user => is { user }
    end
  end
end

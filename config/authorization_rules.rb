authorization do
  role :admin do
    includes :user

    has_permission_on :authorization_rules, :to => :read

    has_permission_on [:assignments, :google_client_login],
      :to => [:index, :show]

    has_permission_on [:contact_details], :to => [:index, :show]

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
      :escalation_policies, :issues, :rotations, :users
    ], :to => [
      :index, :show
    ]
    has_permission_on :issues, :to => [:new, :create]

    has_permission_on :users, :to => [:create_token, :destroy_token] do
      if_attribute :id => is { user.id }
    end

    has_permission_on :rotation_memberships, :to => [:show] do
      if_attribute :user => is { user }
      if_permitted_to :show, :rotation
    end

    has_permission_on :alerting_steps, :to => [:index, :show] do
      if_permitted_to :show, :contact_detail
      if_permitted_to :show, :rotation_membership
    end
    has_permission_on :alerting_steps, :to => [
      :new, :create, :edit, :update, :destroy
    ] do
      if_permitted_to :update, :contact_detail
      if_permitted_to :update, :rotation_membership
    end

    has_permission_on :contact_details, :to => [
      :index, :show, :new, :create, :edit, :update, :destroy
    ] do
      if_attribute :user => is { user }
    end
  end
end

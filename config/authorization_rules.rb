authorization do
  role :admin do
    includes :user

    has_permission_on [
      :contact_details, :escalation_policies, :issues, :rotations, :users
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
    has_permission_on [:issues], :to => [:new]
    has_permission_on [:contact_details], :to => [:edit, :update] do
      if_attribute :user => is { user }
    end
  end
end

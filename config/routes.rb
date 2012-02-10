Escalator::Application.routes.draw do
  resources :assignments

  root :to => "issues#index"

  devise_for :users, :path_prefix => "devise"

  resource :profile, :controller => :users do
    resources :contact_details
  end

  resources :users do
    member do
      post :create_token
      delete :destroy_token
    end
  end

  resources :rotations do
    resources :rotation_memberships
=begin
    resource :membership, :controller => :rotation_memberships do
      resources :alerting_steps
    end
=end
  end

  resources :rotation_memberships do
    resources :alerting_steps
  end


  resources :escalation_policies do
    resources :issues
  end

  resources :issues

  resources :google_client_login_credentials, :to => "google_client_login",
      :except => [:edit, :update]

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end

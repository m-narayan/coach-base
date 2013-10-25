CoachBase::Application.routes.draw do
  devise_for :users, :controllers => {:omniauth_callbacks => 'omniauth_callbacks'}
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
  # match ':controller(/:action(/:id))(.:format)'

  bigbluebutton_routes :default, :scope => 'webconference', :as => 'bigbluebutton'

  resources :users do
    bigbluebutton_routes :room_matchers
    resources :spaces do
      bigbluebutton_routes :room_matchers
    end
  end

  # bigbluebutton_routes :default, :only => 'servers'
  # bigbluebutton_routes :default, :only => 'rooms'
  # bigbluebutton_routes :default, :only => 'recordings'


  # bigbluebutton_routes :default, :controllers => {
  # :servers => 'custom_servers',
  # :rooms => 'custom_rooms',
  # :recordings => 'custom_recordings'
  # }
  match 'course_details',:to => 'frontpage#course_details'
  match 'my_courses',:to => 'frontpage#my_courses'

  resources :payments, only: [:show, :create, :destroy] do
    collection do
      get :success
      get :cancel
      post :notify
    end
  end
end

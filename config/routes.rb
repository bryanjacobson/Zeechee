# Copyright 2012 Bryan Lee Jacobson
Learnshare::Application.routes.draw do

  resources :screens

  resources :items

  resources :topics

  resources :users

  get "home/index"

  get "home/tos"

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
  root :to => "home#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
  resource :session
  match '/login' => "sessions#new", :as => "login"
  match '/logout' => "sessions#destroy", :as => "logout"
  match '/topics' => "topics#index", :as => "index"

  # Topics catalog navigation
  match '/topics/index/:id' => 'topics#index', :as => 'navigate'

  # Topic re-ordering
  match '/topic/up/:id' => 'topics#up', :as => 'up_topic'
  match '/topic/down/:id' => 'topics#down', :as => 'down_topic'

  # Screen re-ordering
  match '/screen/up/:id' => 'screens#up', :as => 'up_screen'
  match '/screen/down/:id' => 'screens#down', :as => 'down_screen'

  # Screen cloning
  match '/screen/clone/:id' => 'screens#clone', :as => 'clone_screen'

  # Item re-ordering
  match '/item/up/:id' => 'items#up', :as => 'up_item'
  match '/item/down/:id' => 'items#down', :as => 'down_item'

end

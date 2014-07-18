Scrum::Application.routes.draw do
  resources :users
  resources :tasks do
    member do
      get "join"
      get "kick"
      get "trequests"
      match "/accept/:trequest_id", to: "tasks#accept"
      match "/decline/:trequest_id", to: "tasks#decline"
    end
    collection do
      get 'browse'
      get "addtask"
    end
  end
  resources :projects do
    member do
      get "join"
      get "kick"
      get "prequests"
      match "/accept/:prequest_id", to: "projects#accept"
      match "/decline/:prequest_id", to: "projects#decline"
    end
    collection do
      get 'browse'
      get "addtask"
    end
  end

  resources :groups do
    member do
      get "join"
      get "kick"
      get "grequests"
      match "/accept/:grequest_id", to: "groups#accept"
      match "/decline/:grequest_id", to: "groups#decline"
    end
    collection do
      get 'browse'
    end
  end
  resources :sessions, only: :create

  match "/",          to: "application#home", :as => :home
  match "/signup",    to: "users#new"
  match "/signin",    to: "sessions#new"
  match "/signout",    to: "sessions#destroy"


  


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
end

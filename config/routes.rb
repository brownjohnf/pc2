OmniauthDemo::Application.routes.draw do

  resources :photos

  resources :moments do
    member do
      get 'decade'
      get 'year'
    end
    collection do
      get 'all'
      get 'span'
      post 'span'
    end
  end

  resources :sites

  resources :sectors

  resources :positions

  resources :jobs

  resources :staff

  resources :websites

  resources :blogs

  resources :feedback, :except => [:edit, :update]

  resources :contributions

  resources :volunteers

  resources :permissions

  resources :scopes

  resources :privileges

  resources :pages do
    collection do
      get :updated
      get :added
      get :popular
    end
  end

  resources :memberships, :only => [ :index, :new, :create, :destroy ]

  resources :groups

  resources :regiontypes

  resources :pcregions

  resources :countries

  resources :regions

  resources :users

  get   '/timeline', :to => 'moments#index'
  get   '/login', :to => 'sessions#new', :as => :login
  get   '/logout', :to => 'sessions#destroy'
  match '/auth/:provider/callback', :to => 'sessions#create'
  match '/auth/failure', :to => 'sessions#failure'

  match 'disclaimer', :to => redirect('/pages/1')
  match 'privacy_policy', :to => redirect('/pages/2')
  match 'support', :to => redirect('/pages/3')
  match 'security', :to => redirect('/pages/4')
  match "about_us", :to => redirect('/pages/5')

  match 'splash', :to => 'static#splash'
  match 'feedback', :to => 'feedback#new'

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
  root :to => 'static#home'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end

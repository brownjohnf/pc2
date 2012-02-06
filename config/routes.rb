OmniauthDemo::Application.routes.draw do

  resources :documents

  resources :settings

  resources :case_studies do
    collection do
      get :added
      get :updated
    end
  end

  resources :identities

  resources :stages

  resources :imports do
    member do
      get 'process_yaml'
    end
  end

  resources :languages

  resources :libraries

  resources :stacks

  resources :photos

  resources :moments, :path => 'timeline' do
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

  resources :blogs do
    collection do
      get :updated
    end
  end

  resources :feedback, :except => [:edit, :update] do
    collection do
      get :volunteer_request
    end
  end

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
      get :ajax
    end
  end

  resources :memberships, :only => [ :index, :new, :create, :destroy ]

  resources :groups

  resources :regiontypes

  resources :pcregions

  resources :regions

  resources :users do
    member do
      put :remove_avatar
    end
  end

  get   '/login', :to => 'sessions#new', :as => :login
  get   '/logout', :to => 'sessions#destroy', :as => :logout
  match '/auth/:provider/callback', :to => 'sessions#create'
  match '/auth/failure', :to => 'sessions#new'

  match '/disclaimer', :to => 'statics#disclaimer'
  match '/privacy', :to => 'statics#privacy'
  match '/support', :to => 'statics#support'
  match '/security', :to => 'statics#security'
  match '/about_us', :to => 'statics#about_us'
  match '/splash', :to => 'statics#splash'
  match '/help', :to => 'statics#help'
  match '/search', :to => 'statics#search'

  match '/feedback', :to => 'feedback#new'
  match '/feed/pages', :to => 'pages#updated'

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
  root :to => 'statics#home'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end

OmniauthDemo::Application.routes.draw do

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  
  devise_scope :user do
    get 'login', :to => 'devise/sessions#new'
    get 'logout', :to => 'devise/sessions#destroy'
  end
  
  resources :users, :only => [ :index, :show, :edit, :update, :destroy ] do
    member do
      put :remove_avatar
    end
  end

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

  resources :stacks, :only => [ :index, :new, :create, :destroy ]

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

  resources :contributions, :only => [ :index, :new, :create, :destroy ]

  resources :volunteers

  resources :permissions, :only => [ :index, :new, :create, :destroy ]

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

  match '/disclaimer', :to => 'statics#disclaimer'
  match '/privacy', :to => 'statics#privacy'
  match '/security', :to => 'statics#security'
  match '/about_us', :to => 'statics#about_us'
  match '/splash', :to => 'statics#splash'
  match '/help', :to => 'statics#help'
  match '/search', :to => 'statics#search'

  match '/feedback', :to => 'feedback#new'
  match '/feed/pages', :to => 'pages#updated'

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'statics#home'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end

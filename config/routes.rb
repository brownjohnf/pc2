OmniauthDemo::Application.routes.draw do

  Mercury::Engine.routes

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  
  devise_scope :user do
    get 'login', :to => 'devise/sessions#new', :as => :login
    get 'logout', :to => 'devise/sessions#destroy', :as => :logout
  end
  
  #constraints :subdomain => '' do
  #  match '/' => redirect('/') #("http://www.pcsenegal.com")
  #end
  
  resources :users, :only => [ :index, :show, :edit, :update, :destroy ] do
    member do
      put :remove_avatar
    end
    collection do
      get :search
      get :table
    end
  end

  resources :documents, :path => 'files' do
    member do
      get :download
    end
    collection do
      get :search
      get :table
    end
  end

  resources :case_studies do
    collection do
      get :added
      get :updated
      get :search
    end
    member do
      post :mercury_update
    end
  end

  resources :imports do
    member do
      get 'process_yaml'
    end
  end

  resources :languages

  resources :libraries do
    member do
      get :download
      get :podcast, :as => :podcast, :defaults => { :format => 'xml' }
    end
  end

  resources :stacks, :only => [ :index, :new, :create, :destroy ]

  resources :photos do
    collection do
      get :search
    end
    member do
      get :embed
    end
  end

  resources :sites, :sectors, :positions, :jobs, :staff, :websites, :identities, :stages, :scopes, :regiontypes, :pc_regions, :regions, :volunteers, :moments

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

  resources :permissions, :only => [ :index, :new, :create, :destroy ]

  resources :pages do
    collection do
      get :updated
      get :added
      get :popular
      get :ajax
      get :search
      get :feed, :as => :feed, :defaults => { :format => 'atom' }
    end
    member do
      post :mercury_update
    end
  end

  match '/disclaimer', :to => 'statics#disclaimer'
  match '/privacy', :to => 'statics#privacy'
  match '/security', :to => 'statics#security'
  match '/about_us', :to => 'statics#about_us'
  match '/splash', :to => 'statics#splash'
  match '/help', :to => 'statics#help'
  match '/search', :to => 'statics#search'
  match '/welcome', :to => 'statics#welcome', :as => :entry
  match '/goodbye', :to => 'statics#goodbye', :as => :exit
  match '/dashboard', :to => 'statics#dashboard', :as => :dashboard
  match '/timeline', :to => 'statics#timeline', :as => :timeline

  match '/feedback', :to => 'feedback#new'
  match '/feed/pages', :to => 'pages#updated'
  
  match '/facebook' => redirect('https://apps.facebook.com/peacecorps_sn/')
  match '/youtube' => redirect('https://www.youtube.com/pcsenegaladmin')
    
  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'statics#splash'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end

require 'sidekiq/web'
Platform::Application.routes.draw do

  get "oauths/oauth"

  get "oauths/callback"

  mount Sidekiq::Web, at: '/sidekiq'

  namespace :api do
    namespace :v1 do
      resources :users
      resources :businesses
      resources :locations
      resources :password_resets, only: :create
      resources :business_pin,    only: :update

      namespace :marketing do
        resources :prizes, only: :create
      end

      post 'sessions' => 'sessions#create'
    end
  end

  resources :sessions, :only => [:create, :destroy]

  match '/users/activate/:token'              => 'users#activate',        :as => :activation
  resources :password_resets
  #match '/password_resets/:reset_token/edit'  => 'password_resets#edit',  :as => :password_reset
  match '/oauth/callback'                     => 'oauths#callback'
  match '/oauth/:provider'                    => 'oauths#oauth',          :as => :auth_at_provider
  
  root :to => 'welcome#index'

end

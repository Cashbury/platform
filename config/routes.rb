require 'sidekiq/web'
Platform::Application.routes.draw do

  get "oauths/oauth"

  get "oauths/callback"

  get "/new" => 'oauths#test'

  mount Sidekiq::Web, at: '/sidekiq'

  namespace :api do
    namespace :v1 do
      resources :users do
        resources :user_prizes, only: :show do
          member { post :redeem }
        end
      end

      resources :engagement
      resources :businesses
      resources :locations
      resources :password_resets, only: :create
      resources :business_pin,    only: :update
      resources :prize_boards

      namespace :game do
        resources :play, only: :create
      end

      namespace :marketing do
        resources :prizes, only: :create
        resources :campaigns
      end

      post    'sessions' => 'sessions#create'
      delete  'sessions' => 'sessions#destroy'
    end
  end

  resources :sessions, :only => [:create, :destroy]

  match '/users/activate/:token'              => 'users#activate',        :as => :activation
  resources :password_resets
  #match '/password_resets/:reset_token/edit'  => 'password_resets#edit',  :as => :password_reset
  match '/oauth/callback'                     => 'oauths#callback'
  match '/oauth/:provider'                    => 'oauths#oauth',          :as => :auth_at_provider
  
  root :to        => 'home#index'
  match '*ember'  => 'home#index'

end

require 'sidekiq/web'
Platform::Application.routes.draw do

  get "oauths/oauth"

  get "oauths/callback"

  mount Sidekiq::Web, at: '/sidekiq'

  namespace :api do
    namespace :v1 do
      resources :users
      resources :businesses

      post 'sessions' => 'sessions#create'
    end
  end

  resources :sessions, :only => [:create, :destroy]

  match '/users/activate/:token'   =>  'users#activate', :as => :activation
  match "oauth/callback" => "oauths#callback"
  match "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider
  
  root :to => 'welcome#index'

end

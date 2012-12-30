require 'sidekiq/web'
Platform::Application.routes.draw do

  mount Sidekiq::Web, at: '/sidekiq'

  namespace :api do
    namespace :v1 do
      resources :users
      resources :businesses
    end
  end

  match '/users/activate/:token'   =>  'users#activate', :as => :activation

  root :to => 'welcome#index'

end

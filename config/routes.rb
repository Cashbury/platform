Platform::Application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :users
    end
  end

  root :to => 'welcome#index'

end

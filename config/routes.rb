require 'sidekiq/web'

Rails.application.routes.draw do
  default_url_options :host => "localhost:3000"
  resources :posts
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  resources :categories
  root "home#index"
  mount Sidekiq::Web => "/sidekiq"

  namespace :api do
    namespace :v1 do
      resources :posts
      resources :categories do 
        get :serachCategory, on: :collection
      end
    end
  end
end

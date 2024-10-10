require 'sidekiq/web'

Rails.application.routes.draw do
  resources :posts
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  resources :categories
  root "home#index"
  mount Sidekiq::Web => "/sidekiq"
end

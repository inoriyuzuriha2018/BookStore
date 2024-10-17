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
end

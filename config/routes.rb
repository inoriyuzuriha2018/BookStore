Rails.application.routes.draw do
  resources :posts
  devise_for :users
  resources :categories
  root "home#index"
end

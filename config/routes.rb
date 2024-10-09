Rails.application.routes.draw do
  get 'home/index'
  devise_for :users
  resources :categories
  root "home#index"
end

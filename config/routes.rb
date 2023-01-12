Rails.application.routes.draw do
  resources :users
  # devise_for :users
  root "events#index"

  resources :events
  resources :users, only: [:show, :edit, :update]
end

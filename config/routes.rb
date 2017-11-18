Rails.application.routes.draw do

  root 'orders#new'

  namespace :admin do
    root to: 'users#index', as: :root
    resources :users
    resources :orders, only: [:index]
    resources :restaurants do
      resources :points
    end
  end

  resources :orders
  resources :user_sessions, only: [:new, :create, :destroy]
  resources :users

  get 'login' => 'user_sessions#new', as: :login
  post 'logout' => 'user_sessions#destroy', as: :logout

end

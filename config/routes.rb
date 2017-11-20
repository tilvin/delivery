Rails.application.routes.draw do

  root 'orders#new'

  namespace :admin do
    root to: 'users#index', as: :root
    resources :users
    resources :orders, only: [:index] do
      get 'set_accepted', on: :member
    end
    resources :restaurants do
      resources :points
    end
  end

  resources :orders do
    get 'set_accepted', on: :member
  end

  resources :user_sessions, only: [:new, :create, :destroy]

  get 'login' => 'user_sessions#new', as: :login
  post 'logout' => 'user_sessions#destroy', as: :logout

end

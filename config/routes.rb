Rails.application.routes.draw do
  resources :iprange, only: [:show] do
    resources :ipaddress, only: [:show]
  end

  resources :customer, only: [:create, :update, :destroy]
  resources :company, only: [:create, :update, :destroy]
  resources :lease, only: [:create, :update, :destroy]
  resources :webspace, only: [:create, :update, :destroy]

  root 'dashboard#index'
  get '/dashboard', to: 'dashboard#index'

  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'registrations'
  }
end

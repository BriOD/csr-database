Rails.application.routes.draw do
  resources :ipranges, only: [:show] do
    resources :ipaddresses, only: [:show]
  end

  get 'customers/:id/move' => 'customers#move', as: :customer_move
  get 'customers/:id/tdnp' => 'customers#tdnp', as: :customer_tdnp

  resources :customers, only: [:create, :update, :destroy]
  resources :companies, only: [:create, :update, :destroy]
  resources :leases, only: [:create, :update, :destroy]
  resources :webspaces, only: [:create, :update, :destroy]

  root 'dashboard#index'
  get '/dashboard', to: 'dashboard#index'
  get '/settings', to: 'dashboard#settings'

  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'registrations'
  }
end

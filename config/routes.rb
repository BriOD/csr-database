Rails.application.routes.draw do
  resources :ipranges, only: [:show] do
    resources :ipaddresses, only: [:show]
  end

  patch 'customers/:id/move' => 'customers#move', as: :customer_move
  get 'customers/:id/tdnp' => 'customers#tdnp', as: :customer_tdnp
  get 'customers/tdnp' => 'customers#show_tdnps', as: :customer_show_tdnps

  get 'ipaddresses/unassigned' => 'ipaddresses#show_unassigned', as: :ipaddresses_show_unassigned

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

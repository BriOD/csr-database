Rails.application.routes.draw do
  resources :ipranges, only: [:show] do
    resources :ipaddresses, only: [:show]
  end
  
  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resources :companies,     only: [:show, :index]
      resources :customers,     only: [:show, :index]
      resources :ipaddresses,   only: [:show, :index]
      resources :ipranges,      only: [:show, :index]
      resources :leases,        only: [:show, :index]
      resources :webspaces,     only: [:show, :index]
    end
  end

  patch  'customers/:id/move'     => 'customers#move',              as: :customer_move
  get    'customers/:id/tdnp'     => 'customers#tdnp',              as: :customer_tdnp
  get    'customers/tdnp'         => 'customers#show_tdnps',        as: :customer_show_tdnps
  get    'ipaddresses/unassigned' => 'ipaddresses#show_unassigned', as: :ipaddresses_show_unassigned
  
  get    '/dashboard',            => 'dashboard#index'
  get    '/settings',             => 'dashboard#settings'
  root   'dashboard#index'

  resources :customers,   only: [:create, :update, :destroy]
  resources :companies,   only: [:create, :update, :destroy]
  resources :leases,      only: [:create, :update, :destroy]
  resources :webspaces,   only: [:create, :update, :destroy]

  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'registrations'
  }
end
